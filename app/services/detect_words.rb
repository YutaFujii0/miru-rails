require 'google/cloud/vision'


class DetectWords
  def self.call(image_path)
    key_file = "/Users/yutafujii/Downloads/miru-lw187-997a31b5b6ef.json"

    vision = Google::Cloud::Vision.new project: "miru-lw187"
    text  = vision.image(image_path).text
    puts text.text
  end
end

url = "/Users/yutafujii/Downloads/menu.jpg"
DetectWords.call(url)
