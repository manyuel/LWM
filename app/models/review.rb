class Review < ApplicationRecord
  belongs_to :transaction
  has_one :product, through: :transactions
  has_one :user, through: :products
end
