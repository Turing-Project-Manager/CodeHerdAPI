require 'rails_helper'

RSpec.describe 'Create Collaboration', type: :request do
  def query(user_id, email, project_id)
    <<~GQL
    mutation {
      createCollaboration(input:{
        userId: #{user_id}
        email: "#{email}",
        projectId: #{project_id}
      }
      ){
        collaborator{
          user{id},
          project{id},
        }
        errors
      }
    }
    GQL
  end

  it 'can add a collaborator onto a project' do
    user_1 = User.create!(name: "Sleepy Kiddo", email: "tired@sigh.com", github_handle: "sigh_le", github_access_token: "thisisagitbuhnoket")
    user_2 = User.create!(name: "Awake Kiddo", email: "nottired@sigh.com", github_handle: "awake_le", github_access_token: "thisisagithubtoken")
    project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)

    post '/graphql', params: { query: query(user_1.id, "#{user_2.email}", project_1.id) }
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:createCollaboration][:collaborator][:project][:id]).to eq("#{project_1.id}")
    expect(parsed[:data][:createCollaboration][:collaborator][:user][:id]).to eq("#{user_2.id}")
  end

  it 'cannot add a collaborator onto a project if the collaborator\'s email is not associated with a user'  do
    user_1 = User.create!(name: "Sleepy Kiddo", email: "tired@sigh.com", github_handle: "sigh_le", github_access_token: "thisisagitbuhnoket")
    not_valid = "notvaild@truth.com"
    project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)

    post '/graphql', params: { query: query(user_1.id, not_valid, project_1.id) }
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:createCollaboration][:errors][0]).to eq("Validation failed: User must exist, User can't be blank")
  end

  xit 'cannot add a collaborator onto a project if the collaborator is already added'  do
    user_1 = User.create!(name: "Sleepy Kiddo", email: "tired@sigh.com", github_handle: "sigh_le", github_access_token: "thisisagitbuhnoket")
    user_2 = User.create!(name: "Awake Kiddo", email: "nottired@sigh.com", github_handle: "awake_le", github_access_token: "thisisagithubtoken")
    project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)

    post '/graphql', params: { query: query(user_1.id, "#{user_1.email}", project_1.id) }
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:createCollaboration][:errors][0]).to eq("Validation failed: User must exist")
  end

  it 'cannot add a collaborator onto a project if the project id is not valid'  do
    def query(user_id, email)
      <<~GQL
      mutation {
        createCollaboration(input:{
          userId: #{user_id}
          email: "#{email}"
        }
        ){
          collaborator{
            user{id},
            project{id},
          }
          errors
        }
      }
      GQL
    end
    user_1 = User.create!(name: "Sleepy Kiddo", email: "tired@sigh.com", github_handle: "sigh_le", github_access_token: "thisisagitbuhnoket")
    user_2 = User.create!(name: "Awake Kiddo", email: "nottired@sigh.com", github_handle: "awake_le", github_access_token: "thisisagithubtoken")

    post '/graphql', params: { query: query(user_1.id, "#{user_2.email}") }
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:errors][0][:message]).to eq("Argument 'projectId' on InputObject 'CreateCollaborationInput' is required. Expected type ID!")
  end
end
