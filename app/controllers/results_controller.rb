require "json"
require "open-uri"

class ResultsController < ApplicationController
  def index
    @menu = Menu.where(user_id: current_user.id)
    # TODO: return all results with image paths
    # set the instances
    @results = Menu.find(params[:menu_id]).results
    # search images for each food
    search_image_for_each_food(@results)
  end

  def order
    # @menu = Menu.where(user_id: current_user.id)
    @orders = Result.where(order: 1, menu_id: params[:menu_id].to_i)

    url = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=udon"

    food_wiki = JSON.parse(open(url).read)
    @food_title = food_wiki["query"]["pages"].values[0]["title"]
    @food_summary = food_wiki["query"]["pages"].values[0]["extract"]
    search_image_for_each_food_order(@orders)
  end

  def update
    @result = Result.find(params[:id])
    @result.order += params[:result][:order].to_i
    @result.order = 0 if @result.order < 0
    @result.save
    respond_to do |format|
        format.js
    end
  end

  private

  def search_image_for_each_food(results)
    # boost threads to imcrease performance
    pool = Concurrent::FixedThreadPool.new(10)
    completed = []

    results.each do |result|
      pool.post do
        # ==========================================
        # ***** FOP DEVELOPMENT purpose *****
        result.food.images = [Food::SAMPLE_IMAGES.sample] if result.food.images.nil?
        # ***** FOP PRODUCTION purpose *****
        # call searhcimages method and store the returned array

        # result.food.images = SearchImages.call(result.food.name) if result.food.images.nil?
        # ==========================================
        completed << 1
      end
    end

    # temporary measure: wait_for_termination does not work well
    sleep(0.1) unless completed.count == results.count
    pool.shutdown
    pool.wait_for_termination
  end

  def search_image_for_each_food_order(results)
    # boost threads to imcrease performance
    pool = Concurrent::FixedThreadPool.new(10)
    completed = []

    @orders.each do |result|
      pool.post do
        # ==========================================
        # ***** FOP DEVELOPMENT purpose *****
        result.food.images = [Food::SAMPLE_IMAGES.sample] if result.food.images.nil?
        # ***** FOP PRODUCTION purpose *****
        # call searhcimages method and store the returned array
        # result.food.images = SearchImages.call(result.food.name) if result.food.images.nil?
        # ==========================================
        completed << 1
      end
    end
    # temporary measure: wait_for_termination does not work well
    sleep(1) unless completed.count == @orders.count
    pool.shutdown
    pool.wait_for_termination
  end
end
