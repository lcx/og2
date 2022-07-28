FactoryBot.define do
  factory :player do
    email { Faker::Internet.safe_email }
    password { 'password' }
  end
end
