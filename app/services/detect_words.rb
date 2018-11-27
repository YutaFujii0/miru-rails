require 'google/cloud/vision'

class DetectWords
  def self.call(image_path)
    vision = Google::Cloud::Vision.new project: ENV["GOOGLE_CLOUD_PROJECT"]
    image = vision.image(image_path)
    { language: image&.text&.locale, text: image&.text&.text } # -> REFERENCE 1 (refer to the bottom)
  end
end

# TODO: to retrieve words and language of the context
# - words will be used to show the result
# - language will be used to improve the relevance of the images of that meal
# See app/services/search_images.rb for more detail.

# REFERENCES
# 1. We set safe navigation operator &.
#     when image has no letters, image.text.locale/image.text.text will cause
#     undefined method *** to the NilClass error.
#     To address this problem, we set safety operator.
#
#     http://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/
