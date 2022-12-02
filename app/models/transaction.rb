class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def to_s
    self.product.item
  end

  def price
    self.product.price
  end

  def self.basket_total(transactions)
    @transactions = transactions.map { |transaction| transaction.product.price.round(2) }.sum
  end
end
