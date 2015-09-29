class ReviewsController < ApplicationController
  def create
    @tattoo = Tattoo.find(params[:tattoo_id])
    @review = @tattoo.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      ReviewMailer.new_review(@review).deliver_later
      flash[:notice] = "Review Added Successfully!"
      redirect_to tattoo_path(@tattoo)
    else
      flash[:errors] = @review.errors.full_messages.join(", ")
      redirect_to tattoo_path(@tattoo)
    end
  end

  def edit
    review = Review.find(params[:id])
    if signed_in? && current_user == review.user
      @review = Review.find(params[:id])
      @tattoo = @review.tattoo
    elsif !signed_in?
      authenticate_user!
    else
      flash[:notice] = 'You have no permission to edit this posting'
      redirect_to tattoo_path(tattoo)
    end
  end

  def update
    @review = Review.find(params[:id])
    @tattoo = @review.tattoo
    if !signed_in?
      authenticate_user!
    elsif @review.update_attributes(review_params)
      flash[:notice] = 'Review successfully updated.'
      redirect_to tattoo_path(@tattoo)
    else
      flash[:error] = @review.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @tattoo = @review.tattoo
    if !signed_in?
      authenticate_user!
    elsif signed_in? && (current_user == @review.user || current_user.admin?)
      @review.destroy
      flash[:notice] = 'Review deleted successfully.'
      redirect_to tattoo_path(@tattoo)
    else
      flash[:notice] = 'You have no permission to delete this posting'
      redirect_to tattoo_path(@tattoo)
    end
  end

  def upvote
    review = Review.find(params[:review_id])
    @tattoo = review.tattoo
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
    render json: review.score
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
    render json: review.score
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :body, :tattoo)
  end
end
