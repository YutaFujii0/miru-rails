class FavouritesController < ApplicationController
  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @favourite.food = Food.find(params[:food_id])
  end

  def show
    @food = Food.find(params[:id])
    @user = User.find(params[:id])

  end


  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :food_id)
  end
end
