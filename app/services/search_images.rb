require 'json'

class SearchImages
  base_url = "https://www.googleapis.com/customsearch/v1?&"
  parameters = {
    cx: ENV["SEARCH_ENGINE_ID"],
    key: ENV["GOOGLE_CUSTOM_SEARCH_KEY"],
    num: 5,
    searchType: "image",
    imgColorType: "color",
    safe: "active",
    fields: "searchInformation(searchTime,totalResults),items/image/thumbnailLink"
  }
  @url = base_url + parameters.map { |k, v| "#{k}=#{v}" }.join("&")

  def self.call(keyword)
    # TODO: return the array that contains image paths of the keyword given
    # create the url
    # open url (GET request) and convert it into json file
    # for each item, pick up elements needed
    # return the array
    # use begin/rescue method for the case the url returns no images
    doc = JSON.parse(open(URI.encode(@url + "&q=#{keyword}")).read)
    {
      popularity: doc["searchInformation"]["totalResults"].to_i,
      image_paths: doc["items"].map { |item| item["image"]["thumbnailLink"] }
    }
  rescue OpenURI::HTTPError => e
    puts "============================================================"
    puts e.message
    puts "Please check if Google Custom Search API exceeds daily query limit."
    puts "============================================================"
    return [Food::DEFAULT_IMAGE]
  end
end
