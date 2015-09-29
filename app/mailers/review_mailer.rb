class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

    mail(
      to: review.tattoo.user.email,
      subject: "New Review for #{review.tattoo.title}"
    )
  end
end
