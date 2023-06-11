class Product < ApplicationRecord 
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  belongs_to :category
  has_one_attached :image
end 