class ReviewsController < ApplicationController
  def create
    @tattoo = Tattoo.find(params[:tattoo_id])
    @review = @tattoo.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      flash[:notice] = "Review Added Successfully!"
      redirect_to tattoo_path(@tattoo)
    else
      flash[:errors] = @review.errors.full_messages.join(", ")
      redirect_to tattoo_path(@tattoo)
    end
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :body, :tattoo)
  end
end
