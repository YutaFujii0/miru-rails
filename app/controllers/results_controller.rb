require "json"
require "open-uri"

class ResultsController < ApplicationController
  def index
    @menu = Menu.where(user_id: current_user.id)

    # TODO: return all results with image paths
    # set the instances
    @results = Menu.find(params[:menu_id]).results
    # search images for each food
    @results_with_data = search_image_for_each_food(@results)
  end
  def order
    @menu = Menu.where(user_id: current_user.id)
    @orders = Result.where(order: 1, menu_id: params[:menu_id].to_i)

    url = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=udon"

    food_wiki = JSON.parse(open(url).read)
    @food_title = food_wiki["query"]["pages"].values[0]["title"]
    @food_summary = food_wiki["query"]["pages"].values[0]["extract"]
    search_image_for_each_food_order
    
    
  end
  def edit
    @result = Result.find(params[:id])
  end
  def update
    @result = Result.find(params[:id])
    if @result.order.nil? || @result.order == 0
      @result.order = 1
    else
      @result.order = 0
    end
    @result.save
    
  end

  private

  def search_image_for_each_food(results)
    # boost threads to imcrease performance
    pool = Concurrent::FixedThreadPool.new(10)
    results_with_data = {}
    completed = []

    results.each do |result|
      pool.post do
        # ==========================================
        # ***** FOP DEVELOPMENT purpose *****
        results_with_data[result] = [Food::SAMPLE_IMAGES.sample]
        # ***** FOP PRODUCTION purpose *****
        # call searhcimages method and store the returned array
        # results_with_data[result] = SearchImages.call(result.food.name)
        # ==========================================
        completed << 1
      end
    end

    # temporary measure: wait_for_termination does not work well
    sleep(0.1) unless completed.count == results.count
    pool.shutdown
    pool.wait_for_termination
    # return
    results_with_data
  end

  def search_image_for_each_food_order
    # boost threads to imcrease performance
    pool = Concurrent::FixedThreadPool.new(10)
    completed = []
    @orders.each do |result|
      pool.post do
        # ==========================================
        # ***** FOP DEVELOPMENT purpose *****
        @results_with_data[result] = [Food::SAMPLE_IMAGES.sample]
        # ***** FOP PRODUCTION purpose *****
        # call searhcimages method and store the returned array
        # @results_with_data[result] = SearchImages.call(result.food.name)
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
