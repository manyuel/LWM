class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    @user = User.find(params[:user_id])
    @product.user = @user
    if @product.save!
      redirect_to
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to _path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:item, :description, :price)
  end

  def set_product
  end
end
