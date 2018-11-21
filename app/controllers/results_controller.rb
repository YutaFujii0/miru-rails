class ResultsController < ApplicationController
  def index
    @menus = Menu.where(user_id: current_user.id)

  end
  def order

  end
end
