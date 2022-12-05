class ProductsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_product, only: %i[show destroy confirm reject]
  before_action :set_user, only: %i[index show destroy create]

  def index
    if params[:category].present?
      @products = Product.where(category: params[:category]).where.not(user_id: @user.id).where(is_sold: false)
      @products = Product.all if @products.empty?
    else
      @products = Product.where.not(user_id: @user.id).where(is_sold: false)
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
      redirect_to products_path
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
    @purchased_products = Transaction.where(user: current_user).map(&:product).select(&:is_delivered)
  end

  private

  def product_params
    params.require(:product).permit(:item, :description, :price, photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
