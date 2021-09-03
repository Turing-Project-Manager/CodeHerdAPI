require 'rails_helper'

RSpec.describe 'Delete Collaborator', type: :request do

  def query(requester_id, collaborator_name, project_id)
    <<~GQL
      mutation {
        deleteCollaborator(
          input: {
            userId: #{requester_id}
            projectId: #{project_id}
            collaborator: "#{collaborator_name}"
          }) {
            errors
          }
        }
    GQL
  end

  it 'should delete a collaborator' do
    user_1 = User.create!(name: "Friday", email: "end_of_the@week.com", github_handle: "looooong_weekend", github_access_token: "thfahfhnoket")
    collaborator = User.create!(name: "Friendo", email: "friend@week.com", github_handle: "sleeping", github_access_token: "thisisHfhdfhken")
    project_1 = Project.create!(name: "Little project", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)
    Collaborator.create!(user_id: user_1.id, project_id: project_1.id)
    collaboration = Collaborator.create!(user_id: collaborator.id, project_id: project_1.id)

    post '/graphql', params: { query: query(user_1.id, "#{collaborator.name}", project_1.id) }

    expect {Collaborator.find(collaboration.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end

  it 'should have an error if the collaboration does not exist' do
    user_1 = User.create!(name: "Friday", email: "end_of_the@week.com", github_handle: "looooong_weekend", github_access_token: "thfahfhnoket")
    collaborator = User.create!(name: "Friendo", email: "friend@week.com", github_handle: "sleeping", github_access_token: "thisisHfhdfhken")
    project_1 = Project.create!(name: "Little project", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)
    Collaborator.create!(user_id: user_1.id, project_id: project_1.id)

    post '/graphql', params: { query: query(user_1.id, "#{collaborator.name}", project_1.id) }

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:deleteCollaborator][:errors][0]).to eq("Could not find this collaboration")
  end

  it 'should have error if the project does not exist' do
    user_1 = User.create!(name: "Friday", email: "end_of_the@week.com", github_handle: "looooong_weekend", github_access_token: "thfahfhnoket")
    collaborator = User.create!(name: "Friendo", email: "friend@week.com", github_handle: "sleeping", github_access_token: "thisisHfhdfhken")

    post '/graphql', params: { query: query(user_1.id, "#{collaborator.name}", 1478264) }

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:deleteCollaborator][:errors][0]).to eq("Project does not exist or the user is not a collaborator")
  end

  it 'should have error if the requester is not associated with the project' do
    user_1 = User.create!(name: "Friday", email: "end_of_the@week.com", github_handle: "looooong_weekend", github_access_token: "thfahfhnoket")
    collaborator = User.create!(name: "Friendo", email: "friend@week.com", github_handle: "sleeping", github_access_token: "thisisHfhdfhken")
    project_1 = Project.create!(name: "Little project", summary: "This is my first project summary", mod_number: "3", owner_id: collaborator.id)

    post '/graphql', params: { query: query(user_1.id, "#{collaborator.name}", project_1.id) }

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:deleteCollaborator][:errors][0]).to eq("Project does not exist or the user is not a collaborator")
  end
end
