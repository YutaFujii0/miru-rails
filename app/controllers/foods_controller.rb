class FoodsController < ApplicationController
  def show
    # @result = Result.find(params[:id])
    # @food = Food.find(@result.food.id)
    @food = Food.find(params[:id])
    @result = Result.find(params[:result_id])
    @favourite = current_user.favourites.find_by(food: @food)
    @food_images = SearchImagesAndPopularity.call(@food.name)
  end
end
