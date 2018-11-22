class StoreImageInCloudinaryJob < ApplicationJob
  queue_as :default

  def perform(menu_instance, image_path)
    File.open(image_path) do |f|
      menu_instance.photo = f
      menu_instance.save!
    end
  end
end
