class FoodsController < ApplicationController
  def show
    @result = Result.find(params[:id])
    @food= Food.find(@result.food.id)
    @food_images = SearchImages.call(@food.name)
  end
end
