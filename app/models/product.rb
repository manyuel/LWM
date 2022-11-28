class Product < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :transactions
  has_many_attached :photos
  validates :item, presence: true
  validates :price, presence: true
  validates :description, length: { minimum: 6 }

end
