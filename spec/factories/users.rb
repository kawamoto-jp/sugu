FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    gender                {"男"}
    email                 {"kkk@gmail.com"}
    password              {"aaaa11"}
    password_confirmation {password}
  end
end
