FactoryBot.define do
  factory :ingredient do
    user
    recipe

    substance { "MyString" }
  end
end
