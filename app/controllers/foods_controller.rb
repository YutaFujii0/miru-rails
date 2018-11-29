class FoodsController < ApplicationController
  def show
    # raise

    # @food = Food.find(@result.food.id)
    if params[:food_id]
      # from results index page
      @food = Food.find(params[:food_id])
      @result = Result.find(params[:id])
      @menu = @result.menu
    else
      # from favourite index page
      @food = Food.find(params[:id])
      # @result = Result.where(food_id: params[:id])
      # @menu = @result.last
    end
    @favourite = current_user.favourites.find_by(food: @food)
    # @food_images = SearchImagesAndPopularity.call(@food.name)
    @fav = Favourite.where(user_id: current_user) #footer favourite number
  end
end
