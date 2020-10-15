class Favorite < ApplicationRecord
  belongs_to :user, optional: true #加えた
  belongs_to :user_info

end
