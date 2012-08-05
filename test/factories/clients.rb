# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    name {Faker::Company.name}
    notes ""
  end
end
