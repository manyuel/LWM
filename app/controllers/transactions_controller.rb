class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_product, only: :create

  def create
    @transaction = Transaction.new(user_id: current_user.id, product_id: @product.id)
    if @transaction.save!
      redirect_to basket_path
    else
      render 'products/show', status: :unprocessable_entity
    end
  end

  def basket
    @transactions = Transaction.where(user_id: current_user.id)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
