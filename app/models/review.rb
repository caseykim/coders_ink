class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :tattoo
  has_many :votes, dependent: :destroy

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..5, message: "Must be 1 through 5" }
  validates :user_id, presence: true
  validates :tattoo_id, presence: true
  validates :user, uniqueness: { scope: :tattoo, message: "has already reviewed this tattoo" }

  def score
    sum = 0
    votes.each do |vote|
      sum += vote.score
    end
    sum
  end
end
