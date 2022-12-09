class TransactionsController < ApplicationController
  before_action :set_product, only: :create
  before_action :set_transaction, only: :destroy

  def create
    @transaction = Transaction.new(user_id: current_user.id, product_id: @product.id)
    if @transaction.save!

    else
      render 'products/show', status: :unprocessable_entity
    end
  end

  def basket
    @transactions = Transaction.where(user_id: current_user.id).reject { |transaction| transaction.product.is_sold}
    @total_amount = @transactions.map { |transaction| transaction.product.price.round(2) }.sum.round(2)
    @order = Order.new(user: current_user, total_amount: @total_amount)

    if !@transactions.empty?
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'gbp',
            unit_amount: (@total_amount * 100).to_i,
            product_data: {
              name: 'Your Order',
              description: ' ',
              images: []
            }
          },
          quantity: 1
        }],
        mode: 'payment',
        success_url: Rails.env.production? ? "http://www.lewagonmarketplace.co/payment" : "http://localhost:3000/payment",
        cancel_url: Rails.env.production? ? "http://www.lewagonmarketplace.co/basket" : "http://localhost:3000/basket"
      )

      @order.update(checkout_session_id: session.id)
    end
  end

  def destroy
    @transaction.destroy
    redirect_to basket_path, status: :see_other
  end

  def checkout
    @transactions = Transaction.where(user_id: current_user.id)
  end

  def confirmation
    @products = current_user.transactions.map(&:product).reject(&:is_sold)
    current_user.transactions.map(&:product).reject(&:is_sold).each do |product|
      product.update(is_sold: true)
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
