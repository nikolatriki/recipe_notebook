FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testing#{n}@test.com" }
    sequence(:handle) { |h| "Chef #{h}" }
    first_name { 'Jeffry' }
    last_name { 'Lebowsky' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
