require 'google/cloud/vision'

class DetectWords
  def self.call(image_path)
    # project_id = Rails.configuration.google_cloud_api[:project]
    vision = Google::Cloud::Vision.new project: "miru-lw187"
    text = vision.image(image_path).text
    p text.text
  end
end
