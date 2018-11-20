class Menu < ApplicationRecord
  belongs_to :user
  has_many :results

  mount_uploader :photo, PhotoUploader
end
