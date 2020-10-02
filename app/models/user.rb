class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :user_info
  has_many :favorites
  has_many :favorite_user_infos, through: :favorites, source: :user_info
  has_many :room_users
  has_many :rooms, through: :room_users

  validates :nickname, presence: true
  validates :gender, presence: true
end
