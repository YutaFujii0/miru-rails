require "json"
require "open-uri"

class ResultsController < ApplicationController
  def index
    # TODO: return all results with image paths
    @results = Menu.find(params[:menu_id]).results
    @results_with_image = @results.map do |result|
      # call searhcimages method and store the returned array
      SearchImages.call(result.food.name)
    end
    raise
  end

  def order
    @orders = Result.where("order > ?", 0)
    @images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROOxkx63-nDWNxgEFCIIDxg4EIB8A16PLTaGfEttPEqFgvtkO8aN9yhtM",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCHPLNtU2fTUJvbA6T7-LNhf6PiTHmJDrlyymgR3vr5jm-O90JgjOdtjI",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUoMnJPRsuCb6FR0DWeEICML84nDYIXLGN7mxKB5xahU9yZ-82JrNxZ7x0",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEbm52BNP-3N9KeD1B-WnC7N6lxIhLG6SWLuP0U82zkHfXeaqUovXx09og",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-Wz7HyCHbgr3AEG4XFfQglZvVh_cdvUOc7BdT7-ajRAJimYytCU3xEDTW",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5ccGlcyS-uo0PNMVimcpP9pgQptx3Gbf50uLcjOmqkOYmlUfpYBil_mPb",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUzJYxy5Jn-mH2nXSzVNvhmg2pKUjj7OTCS_G2eL_8UsIPU6CafCu76mQ",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfw_DGC8E2LiFCI37v_z5L0gQF3pFhqngKf22hBykX_ESPOybDaB9wjIYp",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMAUsY6QemwF48ujlv2et21tPbe1_rQVzeGpyv3L1IkzdyXiXB78jsCog",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi-uTxIS9sz--YeEuhNbIBYGSeN2j0W3c7KUpEg_DxuyaJRi-yc5QTAITo"
  ]

    @menu = Menu.where(user_id: current_user.id)
    url = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=udon"

    food_wiki= JSON.parse(open(url).read)
    @food_summary = food_wiki["query"]["pages"].values[0]["extract"]
  end

  # use this array to show images
  # in real production, we'll use {food.name, image_path} hash or array in the view

end
