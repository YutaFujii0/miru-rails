class FavouritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @favourite = Favourite.where(user_id: @user.id)
    @favourited_foods = Favourite.where(user_id: @user.id)
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
