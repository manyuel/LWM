class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_product, only: :create
  before_action :set_transaction, only: :destroy

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
    @total_amount = @transactions.map { |transaction| transaction.product.price.round(2) }.sum.round(2)
    @order = Order.new(user: current_user, total_amount: @total_amount)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          unit_amount: (@total_amount * 100).to_i,
          product_data: {
            name: 'Your order',
            description: 'Item',
            images: ['https://example.com/t-shirt.png']
          }
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "http://localhost:3000/checkout",
      cancel_url: "http://localhost:3000/checkout"
    )

    @order.update(checkout_session_id: session.id)
  end

  def destroy
    @transaction.destroy
    redirect_to basket_path, status: :see_other
  end

  def checkout
    @transactions = Transaction.where(user_id: current_user.id)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
