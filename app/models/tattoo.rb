class Tattoo < ActiveRecord::Base
  belongs_to :user
  # has_many :reviews
  
  validates :title, presence: true
  validates :url, presence: true
  validates :user_id, presence: true
end
