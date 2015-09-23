class Tattoo < ActiveRecord::Base
  has_many :reviews
  belongs_to :user
  validates :title, presence: true
  validates :url, presence: true
  validates :user_id, presence: true
end
