FactoryBot.define do
  factory :resource do
    name { Faker::Hobby.activity }
    resource_type { Resource.resource_types.keys.sample }
    content { Faker::Lorem.paragraph }
    project
  end
end
    