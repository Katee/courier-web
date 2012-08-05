FactoryGirl.define do
  factory :location do
    name {Faker::Lorem.words.join(' ')}
    address {Faker::Address.street_address}
    postal {Faker::Address.postcode}
    city "Toronto"
    state "Ontario"
    country "Canada"
  end
end
