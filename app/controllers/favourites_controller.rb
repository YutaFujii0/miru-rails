class FavouritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @favourite = Favourite.where(user_id: @user.id)
    @favourited_foods = Favourite.where(user_id: @user.id)
  end

  def create
    @user = User.find(params[:user_id])
    @food = Food.find(params[:food_id])
    @favourite = Favourite.create!(favourite_params)
    @favourite.food = @food
    redirect_to user_favourites_path
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :food_id)
  end
end
