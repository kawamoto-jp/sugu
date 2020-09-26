class UserInfo < ApplicationRecord
  belongs_to :user
  # has_many :room_user_infos
  # has_many :rooms, through: :room_user_infos
  # has_many :messages
  has_one_attached :image


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
