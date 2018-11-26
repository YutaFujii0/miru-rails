class FavouritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @favourited_foods = @user.favourited_foods
    @food_images = SearchImages.call(@user.favourited_foods[0].name)
  end

  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.food = Food.find(params[:food_id])
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :food_id)
  end
end
