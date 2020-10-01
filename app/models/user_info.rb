class UserInfo < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area
  belongs_to_active_hash :people_num

  with_options presence: true do
    validates :text
    validates :image
    validates :area
    validates :people_num
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
