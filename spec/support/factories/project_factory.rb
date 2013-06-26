FactoryGirl.define do
  factory :user do
    name 'Test user'
    email 'testuser@fakeisp.com'
    password 'password'
    password_confirmation 'password'
  end
end
