class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user, optional: true #加えた
end
