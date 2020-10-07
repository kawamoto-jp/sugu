class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :user_info

end
