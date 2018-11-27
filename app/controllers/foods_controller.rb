class FoodsController < ApplicationController
  def show
    # @result = Result.find(params[:id])
    # @food = Food.find(@result.food.id)
    @food = Food.find(params[:id])
    @favourite = current_user.favourites.find_by(food: @food)
    @food_images = SearchImages.call(@food.name)
    @fav = Favourite.where(user_id: current_user) #footer favourite number
  end
end
