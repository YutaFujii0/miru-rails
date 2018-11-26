require 'google/cloud/vision'

class DetectWords
  def self.call(image_path)
    vision = Google::Cloud::Vision.new project: ENV["GOOGLE_CLOUD_PROJECT"]
    image = vision.image(image_path)
    { language: image.text.locale, text: image.text.text }
  end
end
