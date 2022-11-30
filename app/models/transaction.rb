class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def to_s
    self.product.item
  end

  def price
    self.product.price
  end
end
