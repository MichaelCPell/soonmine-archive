FactoryGirl.define do 

  factory :user do
    firstname "Factory"
    sequence(:lastname) {|n| "#{n}"}
    sequence(:email) {|n| @email = "User#{n}@test.com" }
    password "password"
    password_confirmation "password"
  end
end