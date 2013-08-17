# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reminder do
    name "MyString"
    date "MyString"
    user_id 1
    recipient_email "MyString"
  end
end
