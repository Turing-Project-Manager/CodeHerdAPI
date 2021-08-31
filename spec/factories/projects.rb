FactoryBot.define do
  factory :project do
    name { Faker::Lorem.word }
    mod_number { %w[1 2 3 4].sample }
    summary { Faker::Lorem.sentence }
    owner factory: :user
  end
end