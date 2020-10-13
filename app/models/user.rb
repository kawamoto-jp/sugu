class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :user_info, :dependent => :destroy#退会時コメントも削除
  has_many :favorites, dependent: :destroy
  has_many :favorite_user_infos, through: :favorites, source: :user_info
  has_many :room_users
  has_many :rooms, through: :room_users, :dependent => :destroy#退会時コメントも削除
  has_many :messages, :dependent => :destroy#退会時コメントも削除

  with_options presence: :true, on: :registration do |registraiton|
    registraiton.validates :nickname
    registraiton.validates :gender
    registraiton.validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    registraiton.validates :password, length: {minimum: 6}, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
  end

end
