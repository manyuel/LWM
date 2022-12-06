class Product < ApplicationRecord
  CATEGORY = ['Bedroom', 'Kitchenware', 'Living Room & Garden', 'Clothing', 'Electronics', 'Sports & Leisure', 'Other']
  belongs_to :user
  has_many :transactions
  validates :item, :price, :photos, :category, presence: true
  validates :description, length: { minimum: 6, too_short: "%<count> characters is the minimum allowed" }
  has_many_attached :photos
end
