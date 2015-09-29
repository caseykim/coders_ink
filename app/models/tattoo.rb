class Tattoo < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: { maximum: 20 }
  validates :url, presence: true
  validates :user_id, presence: true

  paginates_per 6

  def average_rating
    sum = 0.0
    reviews.each do |review|
      sum += review.rating
    end
    sum = sum / reviews.length
    sum = sum.round(1)
  end

  def self.search(query)
    where("title like ?", "%#{query}%")
  end
end
