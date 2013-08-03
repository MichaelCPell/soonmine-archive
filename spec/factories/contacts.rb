# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    firstname "MyString"
    lastname "MyString"
    relationship "MyString"
    user_id 1
    email "MyString"
  end
end
