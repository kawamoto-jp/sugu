class Area < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '難波' },
    { id: 3, name: '梅田' },
    { id: 4, name: '天王寺' },
    { id: 5, name: '天満' },
  ]

  has_many :user_infos
end
