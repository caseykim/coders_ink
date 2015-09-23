class Tattoo < ActiveRecord::Base
  has_many :reviews
  belongs_to :user
  validates :title, presence: true
  validates :url, presence: true
  validates :user_id, presence: true

  def average_rating
    sum = 0.0
    self.reviews.each do |review|
      sum += review.rating
    end
    sum = sum / self.reviews.length
    sum = sum.round(1)
  end
end
