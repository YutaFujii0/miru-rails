class FavouritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @favourited_foods = @user.favourited_foods
    @food_images = SearchImages.call(@user.favourited_foods[0].name)
  end

  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @result = Result.find(params[:result_id])
    @favourite.food = Food.find(params[:food_id])
    @favourite.save
    redirect_to food_path(@favourite.food, result_id: @result.id)
  end

  def show
    @food = Food.find(params[:id])
    @user = User.find(params[:id])
    @fav = Favourite.where(user_id: current_user) #footer favourite number
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
