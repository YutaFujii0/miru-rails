class FavouritesController < ApplicationController
  def index
    @user = current_user
    @favourited_foods = @user.favourited_foods
    @food_images = SearchImagesAndPopularity.call(@user.favourited_foods[0].name)
  end

  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @result = Result.find(params[:result_id])
    @favourite.food = Food.find(params[:food_id])
    @favourite.save
    redirect_to food_path(@favourite.food, result_id: @result.id)
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.delete
    @result = Result.find(params[:result_id])
    redirect_to food_path(@favourite.food, result_id: @result.id)
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :food_id)
  end
end
