require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def index
    if params[:location].present?
      @products = Product.where("location ILIKE ?", "%#{params[:location]}%").select
    else
      @products = Product.all
    end
  end
end
