class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tattoos, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :email, presence: true
  validates :username, presence: true, length: { maximum: 15 }

  mount_uploader :profile_photo, ProfilePhotoUploader
  paginates_per 18

  def admin?
    role == "admin"
  end
end
