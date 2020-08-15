FactoryBot.define do
  factory :recipe do
    user
    
    title { 'Recipe title'}
    description { 'Recipe descrition'}
  end
end
