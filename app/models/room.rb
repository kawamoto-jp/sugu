class Room < ApplicationRecord
  has_many :room_users
  has_many :users, optional: true, through: :room_users
  has_many :messages
end
