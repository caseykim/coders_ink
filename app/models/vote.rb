class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  validates :score, presence: true
  validates :score, numericality: { only_integer: true }
  validates :score, inclusion: { in: -1..1 }
  validates :user, uniqueness: { scope: :review }
  validates :user, presence: true
  validates :review, presence: true

  # def upvote
  #
  # vote = Vote.new(user: current_user.id, review: params[:review_id], score: 1)
  # if vote.save
  #
  # end
end
