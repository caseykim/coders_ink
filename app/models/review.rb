class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :tattoo

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..5, message: "Must be 1 through 5" }
  validates :user_id, presence: true
  validates :tattoo_id, presence: true
end
