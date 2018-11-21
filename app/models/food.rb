class Food < ApplicationRecord
  has_many :results, dependent: :destroy
end
