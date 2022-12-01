class ProductsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_product, only: %i[show destroy confirm reject]
  before_action :set_user, only: %i[index show destroy]

  def index
    @products = Product.reject(user: @user, is_sold: true)
  end

  def new
    @product = Product.new
    # @user = User.find(params[:user_id])
    redirect_to products_path, status: :see_other
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
    redirect_to _path, status: :see_other
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
