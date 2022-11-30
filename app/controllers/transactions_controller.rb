class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_transaction, only: [:create, :destroy]

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

  def destroy
    @transaction.destroy
    redirect_to basket_path, status: :see_other
  end

  private

  def transaction_params
    params.require(:transaction).permit(transactions: [])
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
