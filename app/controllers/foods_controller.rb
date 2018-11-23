class FoodsController < ApplicationController
  def show
    @result = Result.find(params[:id])
    food = @result.food_id
    @food_name = Food.find(food).name
    @food_images = SearchImages.call(@food_name)
  end
end
