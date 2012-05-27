# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :investor do
    name "MyString"
    description "MyText"
    website "MyString"
    linkedin "MyString"
    status "MyString"
    category "MyString"
    stages "MyString"
  end
end
