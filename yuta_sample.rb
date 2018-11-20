require "google/cloud/vision"
image_path = "~/Download/menu.jpg"

vision = Google::Cloud::Vision.new project: 'miru-lw187'
image  = vision.image image_path

puts image
