FactoryBot.define do
  factory :instruction do
    user
    recipe

    step { "MyText" }
  end
end
