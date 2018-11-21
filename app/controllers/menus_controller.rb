class MenusController < ApplicationController
  def new
    @menu = Menu.new

  end

  def create
    @menu = Menu.new(menu_params)
    @menu.user = current_user
    if @menu.save!
      # if @menu is valid, go on to creating result instances
      # then, redirect to results#index action
      create_result_instances(@menu)
      redirect_to menu_results_path(@menu)
    else
      render 'new'
    end
  end

  private

  def create_result_instances(menu)
    # TODO: when photo is uploaded
    # detect words array from the photo: call DetectWords.call method
    # refine each word
    # create food instance if it's new
    # create result instance

    # this is temporal
    detect_words = "curry udon\nramen\nbeans pasta\npad thai\nfish and chips"

    # uncomment next line for production
    # detect_words = DetectWords.call(menu.photo.metadata["url"])
    refined_words = RefineWords.call(detect_words)
    refined_words.each do |word|
      food = Food.find_by_name(word) || Food.create(name: word)
      Result.create!(menu_id: menu.id, food_id: food.id)
    end
  end

  def menu_params
    params.require(:menu).permit(:photo)
  end
end
