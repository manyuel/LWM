class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    if params[:buy].present?
      @products = Product.where("item ILIKE ?", "%#{params[:buy]}%")
    else
      @products = Product.all
    end
  end
end
