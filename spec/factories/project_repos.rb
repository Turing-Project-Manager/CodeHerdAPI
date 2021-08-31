FactoryBot.define do
  factory :project_repo do
    project
    repo_name { Faker::Lorem.word }
  end
end
