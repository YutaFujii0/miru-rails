class StoreImageInCloudinaryJob < ApplicationJob
  queue_as :default

  def perform(menu_instance, image_path)
    menu_instance.remote_photo_url = image_path
    menu_instance.save!
  end
end
