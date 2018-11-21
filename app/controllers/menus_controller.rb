class MenusController < ApplicationController
  def new
    @menu = Menu.new
  
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.user = current_user
  end

  def menu_params
    params.require(:menu).permit(:photo)
  end
end
