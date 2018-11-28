class FavouritesController < ApplicationController
  def index
    @user = current_user
    if @user.favourited_foods.first.nil?
      @favourited_foods = []
    else
      @favourited_foods = @user.favourited_foods
      @food_images = SearchImagesAndPopularity.call(@user.favourited_foods[0].name)
    end
    @fav = Favourite.where(user_id: current_user)
  end

  def create
    @favourite = Favourite.new
    @favourite.food = Food.find(params[:food_id])
    @favourite.user = current_user
    @favourite.save
    @fav = Favourite.where(user_id: current_user)
    # redirect_to food_path(@favourite.food)
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @food = @favourite.food
    @favourite.delete
    @fav = Favourite.where(user_id: current_user)
    # @result = Result.find(params[:result_id])
    # redirect_to food_path(@favourite.food)
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :food_id)
  end
end
