class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # mount_uploader :avatar, AvatarUploader

  has_many :tattoos
  validates :email, presence: true
  validates :username, presence: true
end
