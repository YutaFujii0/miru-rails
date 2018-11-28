class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :food

  validates_uniqueness_of :user_id, scope: :food_id
end
