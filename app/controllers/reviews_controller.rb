class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @user = User.first
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user.id
    if @review.save!
      # redirect_to user_reviews_path()
    else
      flash[:alert] = "Something went wrong!"
      render :new
    end
  end

  def destroy
    @review.destroy
    # redirect_to products_path, status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
