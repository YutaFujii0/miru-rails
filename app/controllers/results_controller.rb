class ResultsController < ApplicationController
  def index
    # TODO: return all results with image paths
    # set the instances
    # search images for each food

    @results = Menu.find(params[:menu_id]).results
    search_image_for_each_food(@results)
    @fav = Favourite.where(user_id: current_user) #footer favourite number
    @all = @results.to_json
  end

  def order
    @orders = Result.where("results.order > ?", 0).where(menu_id: params[:menu_id].to_i)

    url = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=udon"

    food_wiki = JSON.parse(open(url).read)
    @food_title = food_wiki["query"]["pages"].values[0]["title"]
    @food_summary = food_wiki["query"]["pages"].values[0]["extract"]
  end

  # for the order page/ + and - icon
  def update
    @result = Result.find(params[:id])
    @result.order += params[:result][:order].to_i
    @result.order = 0 if @result.order < 0
    @result.save
    respond_to do |format|
      format.js
    end
  end

  # for the result#index page/ check icon
  def toggle
    @result = Result.find(params[:id])
    @result.order = @result.order.zero? ? 0 : 1
    respond_to do |format|
      format.js
    end
  end

  private

  def search_image_for_each_food(results)
    # boost threads to increase performance
    pool = Concurrent::FixedThreadPool.new(10)
    completed = []

    translation_of_meal = Language.find_by(code: results.first.lang).meal_is # -> REFERENCE 1 (refer to the bottom)
    results.each do |result|
      pool.post do
        # ==========================================
        if result.food.images.nil?
          result.food.images = [Food::SAMPLE_IMAGES.sample]
          result.food.save!
        end
        # ------------------------------------------
        # if result.food.images.nil?
        #   keyword = "#{result.food.name}+#{translation_of_meal}"
        #   attributes = SearchImagesAndPopularity.call(keyword)
        #   result.food.popularity = attributes[:popularity]
        #   result.food.images = attributes[:image_paths]
        #   result.food.save!
        # end
        # ==========================================
        completed << 1
      end
    end
    # temporary measure: wait_for_termination does not work well
    sleep(0.1) unless completed.count == results.count
    pool.shutdown
    pool.wait_for_termination
  end
end

# REFERENCES
# 1. Here, we get the string of 'meal' translated to the language of the menu.
#     This variable is used for creating keyword which we pass to the API.
#     The reason for this is to improve the relevance of the result images.
#     For example, Japanese menu has lot of fishes which really is 'sashimi',
#     but if you put those words API returns the fish itself not the meal.
#     There are other possibilities as an additional keyword to search with:
#       - food(english)
#       - meal(english)
#       - 'food'(translated to that lang)
#     However we feel 'meal'(translated) is the best performer.
