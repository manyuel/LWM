class ProductsController < ApplicationController
  before_action :set_product, only: %i[show destroy confirm reject]
  before_action :set_user, only: %i[index show destroy create]

  def index
    if params[:category].present? && params[:buy].present?
      @pagy, @products = pagy(Product.where(category: params[:category]).where("item ILIKE ?", "%#{params[:buy]}%").where.not(user_id: @user.id).where(is_sold: false))
    elsif params[:category].present? && params[:buy].nil?
      @pagy, @products = pagy(Product.where(category: params[:category]).where.not(user_id: @user.id).where(is_sold: false))
    elsif params[:buy].present? && params[:category].nil?
      @pagy, @products = pagy(Product.where("item ILIKE ?", "%#{params[:buy]}%").where.not(user_id: @user.id).where(is_sold: false))
    else
      @pagy, @products = pagy(Product.where.not(user_id: @user.id).where(is_sold: false))
    end
  end

  def new
    @product = Product.new
  end

  def show
  end

  def create
    @product = Product.new(product_params)
    @product.user = @user
    if @product.save!
      redirect_to my_products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  def my_products
    @listed_products = Product.where(user: current_user, is_sold: false)
    @sold_products = Product.where(user: current_user, is_sold: true)
  end

  def purchased_products
    unfinished_transactions = Transaction.where(user: current_user).where('is_delivered = ?', false)
    unfinished_transactions_ids = unfinished_transactions.map { |transaction| transaction.product.id }
    @purchased_products = Product.where(id: unfinished_transactions_ids, is_sold: true)
  end

  def user_dashboard
    @listed_products = Product.where(user: current_user, is_sold: false)
    @sold_products = Product.where(user: current_user, is_sold: true)
    unfinished_transactions = Transaction.where(user: current_user).where('is_delivered = ?', false)
    unfinished_transactions_ids = unfinished_transactions.map { |transaction| transaction.product.id }
    @purchased_products = Product.where(id: unfinished_transactions_ids, is_sold: true)
  end

  private

  def product_params
    params.require(:product).permit(:item, :description, :price, :category, photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
