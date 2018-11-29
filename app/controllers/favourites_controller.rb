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
    if @favourite.save!
      @fav = Favourite.where(user_id: current_user)
      respond_to do |format|
        format.html { redirect_to food_path(@favourite.food) }
        format.js
      end
    else # -> REFERENCE 1 (refer to the bottom)
      flash[:alert] = "That food is already added in your favourites."
      render 'index'
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @food = @favourite.food
    @favourite.delete
    @fav = Favourite.where(user_id: current_user)
    respond_to do |format|
      format.html { redirect_to food_path(@favourite.food) }
      format.js
    end
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :food_id)
  end
end

# REFERENCES
# 1. This else statement is theoretically required. But it should never be run.
#     Because we don't set POST request in Food#show view when that food is
#     already added. Thus, if you see this else statement run, something wrong
#     with Food#show view or .js file.
