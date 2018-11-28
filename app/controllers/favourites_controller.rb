class FavouritesController < ApplicationController
  def index
    @user = current_user
    @favourited_foods = @user.favourited_foods
    @food_images = SearchImagesAndPopularity.call(@user.favourited_foods[0].name)
    @fav = Favourite.where(user_id: current_user)
  end

  def create
    @favourite = Favourite.new
    @favourite.food = Food.find(params[:food_id])
    @favourite.user = current_user
    @favourite.save
    @fav = Favourite.where(user_id: current_user)
    respond_to do |format|
      format.html { redirect_to food_path(@favourite.food) }
      format.js
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @food = @favourite.food
    @favourite.delete
    @fav = Favourite.where(user_id: current_user)
    respond_to do |format|
      # format.html { redirect_to food_path(@favourite.food) }
      format.js
    end
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :food_id)
  end
end
