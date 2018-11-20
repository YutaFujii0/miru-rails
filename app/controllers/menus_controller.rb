require "google/cloud/vision"
require 'net/http'
require 'json'
class MenusController < ApplicationController
  def new
    @menu = Menu.new
    url = "https://www.googleapis.com/customsearch/v1?key=AIzaSyBSPZb5vnrwpc3k-BTZoyrd8VB9Wr0wIBc&cx=012820589925743782948:zubopphjzvw&q=udon+food&source=lnms&tbm=isch"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    rake = JSON.parse(response)
    images = []
    rake["items"].each do |item|
      if item["pagemap"]["cse_image"].nil?
        if item["pagemap"]["imageobject"].nil?
        else
        images << item["pagemap"]["imageobject"][0]["contenturl"]
        end

      else
        images << item["pagemap"]["cse_image"][0]
      end
    end
    @vis = []
    vision = Google::Cloud::Vision.new
    @vis << vision.image(images[0]["src"]).label

    @visss = []

    viss = Google::Cloud::Vision.new
    fel = "/Users/arifmohammad/code/NinthAutumn/miru-rails/app/assets/images/menu.jpg"
    @visss << viss.image(fel).text

    raise

  end
  
  def create
    @menu = Menu.new(menu_params)
    @menu.user = current_user
  end

  def menu_params
    params.require(:menu).permit(:photo)
  end
end
