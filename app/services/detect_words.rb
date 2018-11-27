require 'google/cloud/vision'

class DetectWords
  def self.call(image_path)
    vision = Google::Cloud::Vision.new project: ENV["GOOGLE_CLOUD_PROJECT"]
    image = vision.image(image_path)
    { language: image.text.locale, text: image.text.text }
  end
end

# TODO: to retrieve words and language of the context
# - words will be used to show the result
# - language will be used to improve the relevance of the images of that meal
# See app/services/search_images.rb for more detail.
