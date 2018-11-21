class Menu < ApplicationRecord
  belongs_to :user
  has_many :results, dependent: :destroy

  mount_uploader :photo, PhotoUploader
end
