require 'google/cloud/vision'

class DetectWords
  def self.call(image_path)
    vision = Google::Cloud::Vision.new project: ENV["GOOGLE_CLOUD_PROJECT"]
    text = vision.image(image_path).text
    text.text
  end
end
