class ProductsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_product, only: %i[show destroy confirm reject]
  before_action :set_user, only: %i[index show destroy create]

  def index
    if params[:category].present?
      @products = Product.where(category: params[:category])
      @products = Product.all if @products.empty?
    else
      @products = Product.all
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

  def listed_items
    @listed_items = Product.where(user: current_user, is_sold: false)
  end

  def sold_items
    @sold_items = Product.where(user: current_user, is_sold: true)
  end

  def purchased_items
    @purchased_items = Product.where(user: current_user, is_sold: true, is_delivered: true)
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
