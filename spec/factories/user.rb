FactoryBot.define do 
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    sequence(:first_name){ |n| "testf#{n}" }
    sequence(:last_name){ |n| "testl#{n}" }
    password {'123456'}
    password_confirmation {'123456'}
  end
end
