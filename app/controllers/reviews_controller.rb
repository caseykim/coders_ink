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

  def upvote
    review = Review.find(params[:review_id])
    tattoo = review.tattoo
    vote = Vote.find_by(user: current_user, review: review)
    if vote
      if vote.score == 1
        vote.score = 0
      else
        vote.score = 1
      end
      vote.save
    else
      Vote.create(user: current_user, review: review, score: 1)
    end
    redirect_to tattoo_path(tattoo)
  end

  def downvote
    review = Review.find(params[:review_id])
    tattoo = review.tattoo
    vote = Vote.find_by(user: current_user, review: review)
    if vote
      if vote.score == -1
        vote.score = 0
      else
        vote.score = -1
      end
      vote.save
    else
      Vote.create(user: current_user, review: review, score: -1)
    end
    redirect_to tattoo_path(tattoo)
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :body, :tattoo)
  end
end
