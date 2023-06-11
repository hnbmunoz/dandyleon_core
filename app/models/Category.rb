class Category < ApplicationRecord  
  validates :name, presence: true, uniqueness: true
  # alias_attribute  :category_name, :name
  has_many :products
end