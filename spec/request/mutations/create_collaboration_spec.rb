require 'rails_helper'

RSpec.describe 'Create Collaboration', type: :request do
  it 'anythinginhere' do
    def query(user_id, email, project_id)
      <<~GQL
      mutation {
        createCollaboration(input:{
          userId: #{user_id}
          email: "#{email}",
          projectId: #{project_id}
        }
        ){
          collaboration{
            userId,
            projectId,
          }
          errors
        }
      }
      GQL
    end

    user_1 = User.create!(name: "Sleepy Kiddo", email: "tired@sigh.com", github_handle: "sigh_le", github_access_token: "thisisagitbuhnoket")
    user_2 = User.create!(name: "Awake Kiddo", email: "nottired@sigh.com", github_handle: "awake_le", github_access_token: "thisisagithubtoken")
    project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)

    post '/graphql', params: { query: query(user_1.id, "#{user_2.email}", project_1.id) }
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:createCollaboration][:collaboration][:projectId]).to eq(project_1.id)
    expect(parsed[:data][:createCollaboration][:collaboration][:userId]).to eq(user_2.id)
  end
end
