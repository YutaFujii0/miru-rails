class MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def create
    # <procedure>
    # 1-1-1. Call GoogleCloudVision API and retrieve { language: text: } hash
    # 1-1-2. Refine the detected words
    # ->     Check if the photo contains any word
    # 1-2-1. Create Menu instance and save
    # 1-2-2. Upload photo
    # 2.     Create Result instances
    # 3.     Redirect to result#index path
    # <NOTE>
    # Using sidekiq: 1-1/1-2-1
    # This is because
    #   - both processes take much time
    #   - while there's no need to run both sequentially
    # See app/services/detect_words.rb for method calling API


    # uncomment either part -> REFERENCE 1 (refer to the bottom)
    # ==========================================
    detect_words = "本日のおすすめ\n播磨産生カキ\nお刺身盛合せ\n秋田しいたけ\nピクルス\n天ぷら\nマヨチーズ焼き5 9\nサーモンとキノコ\nちょい盛890円\n生カキポン酢 490\nタバスコケチャップ490一\n小1490円\n大2490円\n390\n490\nパプリカソース\n|三種盛り\n490|\n北方四島産\nウニ軍艦 350サーモンとキノコホイル焼き\nウニ刺身 890|1111\n490\nクリームピザ890\nいわて山田産\nカキ\n690\nカキフライ2個490\n490\nクリームコロッケ2個490\n藉之\n1590||みょうがの甘酢漬390-\nカキ天ぷら2個\nお刺身\n谷中生姜甘酢漬390\n:らっきょ\n6\n白子ポン酢790\nバター醤油焼き990自家製メサバ490 …豚タン味噌煮490\nしぐれ煮\nオイル漬け 490コハダ酢締め490\n自家製\nカキ味噌小鍋\n990スズキ\n490アジ\n490…寄せ鍋2人前249\n2\nいわてもりおか\n豚バラ炙り焼き79\n|肩ロース炙り焼き9g\nネギトロつまみ590\nとろたくつまみ590-紅木豚(こうぼくとん\nタコブツ\nあん肝ジャガバタ590\n590\nスルメイカ刺身5 9 0\nイカ肝沖漬490\n1790\nぱくだん\nおろしとんかつ9qC\n角煮大根玉子 790\n一夜干し590\nいかごろ焼き"
    words = { language: "ja", text: RefineWords.call(detect_words) }
    # ------------------------------------------
    # words = GoogleCloudVisionJob.perform_now(params[:menu][:photo].tempfile.path)
    # ==========================================

    if words[:text].nil? # -> REFERENCE 5 (refer to the bottom)
      flash[:alert] = "We can't detect any words from your photo."
      redirect_to root_path
    else
      @menu = Menu.new # -> REFERENCE 2 (refer to the bottom)
      @menu.user = current_user
      if @menu.save!
        StoreImageInCloudinaryJob.perform_now(@menu, menu_params[:photo].tempfile.path)
        sleep(0.1) unless words # -> REFERENCE 3 (refer to the bottom)
        create_result_instances(@menu, words[:language], words[:text])
        redirect_to menu_results_path(@menu)
      else
        render 'new'
      end
    end
  end

  private

  def create_result_instances(menu, language, words)
    # <procedure>
    # 1. create food instance if it's new
    # 2. create result instance with the food_id, menu_id and language
    words.each do |word|
      food = Food.find_by_name(word) || Food.create(name: word)
      Result.create!(menu_id: menu.id, food_id: food.id, lang: language) # -> REFERENCE 4 (refer to the bottom)
    end
  end

  def menu_params
    params.require(:menu).permit(:photo)
  end
end

# REFERENCES
# 1. When using API, we set the optional code so that you can develop wiothout
#     using APIs. It saves your usage limits.
#     every time you see this structure, uncomment either part
#     For example:
#       ==========================================
#       Uncomment first part when you don't want to call APIs
#       ------------------------------------------
#       Uncomment second part when you intend to call APIs
#       Be noted that you should uncomment here when you deploy
#       ==========================================

# 2. usually we populate with photo as attribute, but this case we don't pass
#     photo because it takes much time to populate. Instead, we assign photo
#     just after initiation using sidekiq so that ruby can proceed to next code.

# 3. We set sleep() to wait until GoogleCloudVision API returns the result.
#     This is because in the following step, we use language and detected words
#     to populate Result / Food instances.

# 4. As to which table to add language column, there are 2 possibilities:
#     - Results table
#     - Food table
#     We set it into Results table, but it might be better to set inside Food table.
#     We use this language column when we search images for each food.
#     See results controller, "search_image_for_each_food" method for more detail.

# 5. When user upload photo which Google cant detect any words, redirect to LP
#     For better user experience, we give feedback message.
#     This feedback message is on template Devise gem, thus
#     - See Devise gem README file for more detail about syntax flash[:alert]
#     - Better to create custom flash template
#     <NOTE>
#     As this line we don't have Menu instance, 'render :new' causes error.
