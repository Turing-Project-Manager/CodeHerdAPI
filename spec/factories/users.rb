FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    slack_handle { Faker::Internet.user_name }
    github_handle { Faker::Internet.user_name }
    # working_styles {}
    cohort { Faker::Number.between(from: 1000, to: 9999) }
    pronouns { %w[he/him she/her they/them].sample }
    github_access_token { Faker::Internet.password }
  end
end
