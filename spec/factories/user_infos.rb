FactoryBot.define do
  factory :user_info do
    text                {"よろしくお願いします！"}
    area_id             {"2"}
    people_num_id       {"2"}
    association :user
    
    after(:build) do |user_info|
      user_info.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
