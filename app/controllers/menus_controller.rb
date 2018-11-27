class MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def create
    # <procedure>
    # 1-1-1. Call GoogleCloudVision API and retrieve { language: text: } hash
    # 1-1-2. Refine the detected words
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
    detect_words = "かんぱち\nうどん\nお好み焼き\n天丼"
    words = { language: "ja", text: RefineWords.call(detect_words) }
    # ------------------------------------------
    # words = GoogleCloudVisionJob.perform_now(params[:menu][:photo].tempfile.path)
    # ==========================================

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
