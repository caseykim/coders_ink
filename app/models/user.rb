class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # mount_uploader :avatar, AvatarUploader

  has_many :tattoos
  has_many :reviews
  validates :email, presence: true
  validates :username, presence: true
end
