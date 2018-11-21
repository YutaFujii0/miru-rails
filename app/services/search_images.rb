require 'json'

class SearchImages
  def self.call(keyword)
    # TODO: return the array that contains image paths of the keyword given
    # create the url
    # open url (GET request) and convert it into json file
    # for each item, pick up elements needed
    # return the array

    base_url = "https://www.googleapis.com/customsearch/v1?&"
    parameters = {
      q: keyword,
      cx: ENV["SEARCH_ENGINE_ID"],
      key: ENV["GOOGLE_APPLICATION_CREDENTIALS"],
      num: 10,
      searchType: "image",
      imgColorType: "color",
      safe: "active",
      fields: "searchInformation(searchTime,totalResults),items/image/thumbnailLink"
    }
    url = base_url + parameters.map { |k, v| "#{k}=#{v}" }.join("&")
    doc = JSON.parse(open(url).read)
    return doc.items.map { |item| item.image.thumbnailLink }
  end
end

puts SearchImages.call("udon")
