FactoryBot.define do
  factory :pick do
    team { nil }
    competitor { nil }
  end

  factory :competitor do
    name { "MyString" }
    competition { nil }
  end

  factory :competition do
    name { "MyString" }
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    first_name { "Joe" }
    last_name { "Bloggs" }
    email { generate :email }
    password { "password" }
  end

end
