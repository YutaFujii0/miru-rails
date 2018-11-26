class FavouritesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @food = Food.find(params[:food_id])
    @favourite = Favourite.new()
    @favourite.user = current_user
    @favourite.food = @food
    raise
    if @favourite.save
      redirect_to favourite_path(@user)
    else
      render "show"
    end
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
