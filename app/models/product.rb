class Product < ApplicationRecord
  belongs_to :user
  validates :item, presence: true
  validates :price, presence: true
  validates :description, length: { minimum: 6, too_short: "%<count> characters is the minimum allowed" }
  has_many_attached :photos

end
