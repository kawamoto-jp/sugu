class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :user_info
  has_many :favorites, dependent: :destroy
  has_many :favorite_user_infos, through: :favorites, source: :user_info
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages

  with_options presence: :true do
    validates :nickname
    validates :gender
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, length: {minimum: 6}, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
  end

end
