class MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def create
    # puts DetectWords.call(params[:menu][:photo].tempfile.path)
    t = Time.now
    words = GoogleCloudVisionJob.perform_now(params[:menu][:photo].tempfile.path)
    StoreImageInCloudinaryJob.perform_later(menu_params)
    @menu = Menu.new
    @menu.user = current_user
    if @menu.save!
      # if @menu is valid, go on to creating result instances
      # then, redirect to results#index action
      puts "============#{Time.now - t}"
      sleep(1) unless words
      puts "============#{Time.now - t}"
      raise
      create_result_instances(@menu, words)
      redirect_to menu_results_path(@menu)
    else
      render 'new'
    end
  end

  private

  def create_result_instances(menu, words)
    # create result instance
    # create food instance if it's new
    words.each do |word|
      food = Food.find_by_name(word) || Food.create(name: word)
      Result.create!(menu_id: menu.id, food_id: food.id)
    end
  end

  def menu_params
    params.require(:menu).permit(:photo)
  end
end
    # temporary memo
    # detect words array from the photo: call DetectWords.call method
    # refine each word
    # ==========================================
    # ***** FOP DEVELOPMENT purpose *****
    # detect_words = "00000000000 1000\n本日のおすすめ\n播磨産生カキ\nお刺身盛合せ\n秋田しいたけ\nピクルス\n天ぷら\nマヨチーズ焼き5 9\nサーモンとキノコ"
    # ***** FOP PRODUCTION purpose *****
    # detect_words = DetectWords.call(menu.photo.metadata["url"])
    # ==========================================
    # refined_words = RefineWords.call(detect_words)
