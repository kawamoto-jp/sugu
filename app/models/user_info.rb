class UserInfo < ApplicationRecord
  belongs_to :user
  # has_many :room_user_infos
  # has_many :rooms, through: :room_user_infos
  # has_many :messages
  has_one_attached :image

  belongs_to :user
  has_many :favorites

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  
  # has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # has_many :followings, through: :active_relationships, source: :follower

  # has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  # has_many :followers, through: :passive_relationships, source: :following

  # def followed_by?(user_info)
  #   # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
  #   passive_relationships.find_by(following_id: user_info.id).present?
  # end


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area
  belongs_to_active_hash :people_num

  with_options presence: true do
    validates :text
    validates :image
    validates :area
    validates :people_num
  end

  with_options numericality: { other_than: 1 } do
    validates :people_num_id
    validates :area_id
  end
  
  
end
