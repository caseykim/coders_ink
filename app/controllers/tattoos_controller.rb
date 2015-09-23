class TattoosController < ApplicationController
  def index
    @tattoos = Tattoo.order(id: :desc)
  end

  def show
    @tattoo = Tattoo.find(params[:id])
    @review = Review.new
    @reviews = @tattoo.reviews
    @average_rating = rating_average(@reviews)
  end

  def new
    @tattoo = Tattoo.new
  end

  def create
    @tattoo = Tattoo.new(tattoo_params)
    @tattoo.user = current_user
    if @tattoo.save
      redirect_to tattoo_path(@tattoo)
    else
      flash[:error] = @tattoo.errors.full_messages.join(", ")
      render :new
    end
  end

  protected

  def tattoo_params
    params.require(:tattoo).permit(:title, :description, :url, :studio, :artist)
  end

  def rating_average(reviews)
    sum = 0.0
    reviews.each do |review|
      sum += review.rating
    end
    sum = sum / reviews.length
    sum = sum.round(1)
  end
end
