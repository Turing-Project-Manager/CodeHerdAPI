require 'rails_helper'

RSpec.describe 'Edit Project', type: :request do
  describe 'update project summary' do
    it 'allows a collaborator to update the summary' do
      user_1 = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
      project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)
      collaboration_1 = Collaborator.create!(user_id: user_1.id, project_id: project_1.id )
      summary = "This is the new summary, yay!"

      def query(user_id, project_id, summary)
        <<~GQL
        mutation {
          editProject(input:{
            userId: #{user_id},
            projectId: #{project_id},
            summary: "#{summary}"
            }
            ){
              project{
                id,
                summary
                }
                }
              }
        GQL
      end

      post '/graphql', params: { query: query(user_1.id, project_1.id, summary) }
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:editProject][:project][:id]).to eq("#{project_1.id}")
      expect(parsed[:data][:editProject][:project][:summary]).to eq(summary)
    end

    it 'gives an error when the project does not exist' do
      user_1 = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
      project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user_1.id)
      collaboration_1 = Collaborator.create!(user_id: user_1.id, project_id: project_1.id )
      summary = "This is the new summary, yay!"

      def query(user_id, project_id, summary)
        <<~GQL
        mutation {
          editProject(input:{
            userId: #{user_id},
            projectId: #{project_id},
            summary: "#{summary}"
            }
            ){
              project{
                id,
                summary
                }
                errors
                }
              }
        GQL
      end

      post '/graphql', params: { query: query(user_1.id, "1387", summary) }
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:editProject][:errors][0]).to eq("Please give a valid user id and project id.")
    end
  end
end
