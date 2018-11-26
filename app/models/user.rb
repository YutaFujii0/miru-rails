class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :menus, dependent: :destroy
  has_many :favourites, dependent: :destroy
  # has_many :foods, through: :favourites
  has_many :favourited_foods, class_name: 'Food', through: :favourites, source: :food
end
