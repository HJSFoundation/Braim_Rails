FactoryGirl.define  do
  factory :user do
    name "Bob"
    last_name "Tester"
    country "colombia"
    password "12345678"
    sequence(:email) {|n| "test_email#{n}@example.com"}
    factory :user_with_profile do
      profile 
    end
  end
end