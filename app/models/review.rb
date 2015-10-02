class Review < ActiveRecord::Base
  RATINGS = [1, 2, 3, 4, 5]

  belongs_to :user
  belongs_to :tattoo
  has_many :votes, dependent: :destroy

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: RATINGS, message: "Must be 1 through 5" }
  validates :user_id, presence: true
  validates :tattoo_id, presence: true
  message = "has already reviewed this tattoo"
  validates :user_id, uniqueness: { scope: :tattoo_id, message: message }

  def score
    sum = 0
    votes.each do |vote|
      sum += vote.score
    end
    sum
  end
end
