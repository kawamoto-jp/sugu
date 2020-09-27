class Relationship < ApplicationRecord
  belongs_to :following, class_name: "UserInfo"
  belongs_to :follower, class_name: "UserInfo"
end
