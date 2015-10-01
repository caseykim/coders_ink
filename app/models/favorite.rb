class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :tattoo

  validates :user_id, presence: true
  validates :tattoo_id, presence: true
  validates :user_id, uniqueness: { scope: :tattoo_id }
end
