require 'rails_helper'

RSpec.describe 'update project summary' do
  it 'allows a collaborator to update the summary' do
    user_1 = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
    project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)
    collaboration_1 = Collaborator.create!(user_id: user_1.id, project_id: project_1.id )

    post '/graphql', params: { query: "{updateSummary}" }
  end
end
