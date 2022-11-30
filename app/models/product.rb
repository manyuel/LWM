class Product < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :item, :price, :photos, presence: true
  validates :description, length: { minimum: 6, too_short: "%<count> characters is the minimum allowed" }
  has_many_attached :photos
end
