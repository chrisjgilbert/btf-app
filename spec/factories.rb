FactoryBot.define do
  factory :league_membership do
    league { nil }
    team { nil }
  end

  factory :league do
    name { "MyString" }
    user { nil }
  end

  factory :competition do |comp|
    comp.sequence(:name) { |n| "Competition #{n}" }
  end

  sequence :competition_name do |n|
    "Competition #{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :competition_id do |n|
    n
  end
  
  factory :user do
    first_name { "Joe" }
    last_name { "Bloggs" }
    email { generate :email }
    password { "password" }
  end

  factory :competitor do |comp|
    comp.sequence(:name)           { |n| "Player #{n}" }
    comp.sequence(:competition_id) { |n| n }
  end

end
