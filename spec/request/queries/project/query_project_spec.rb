require 'rails_helper'

RSpec.describe 'query project', type: :request do
  describe 'project information' do
    it 'can find all projects for a user' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y", slack_handle: "turingKiddo")
      project_1 = Project.create!(name: "My project 1", summary: "This is my first project summary", mod_number: "3", owner_id: user.id)
      project_2 = Project.create!(name: "My project 2", summary: "This is my second project summary", mod_number: "3", owner_id: user.id)
      project_3 = Project.create!(name: "My project 3", summary: "This is my third project summary", mod_number: "4", owner_id: user.id)

      post '/graphql', params: { query: "{ usersProjects(userId: #{user.id}) {name, summary, modNumber} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed[:data][:usersProjects]).to be_an(Array)
      expect(parsed[:data][:usersProjects].count).to eq(3)
      expect(parsed[:data][:usersProjects][0]).to include(name: project_1.name, summary: project_1.summary, modNumber: project_1.mod_number)
      expect(parsed[:data][:usersProjects][1]).to include(name: project_2.name, summary: project_2.summary, modNumber: project_2.mod_number)
      expect(parsed[:data][:usersProjects][2]).to include(name: project_3.name, summary: project_3.summary, modNumber: project_3.mod_number)
    end

    it 'returns project name information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y", slack_handle: "turingKiddo")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)

      post '/graphql', params: { query: "{ project(id: #{project.id}) {name} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:project][:name]).to eq(project.name)
    end

    it 'returns project summary information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y", slack_handle: "turingKiddo")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)

      post '/graphql', params: { query: "{ project(id: #{project.id}) {summary} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:project][:summary]).to eq(project.summary)
    end

    it 'returns project mod_number information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y", slack_handle: "turingKiddo")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)

      post '/graphql', params: { query: "{ project(id: #{project.id}) {modNumber} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:project][:modNumber]).to eq(project.mod_number)
    end

    it 'returns project owner id information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y", slack_handle: "turingKiddo")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)

      post '/graphql', params: { query: "{ project(id: #{project.id}) {owner {id}} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:project][:owner][:id]).to eq("#{project.owner.id}")
    end
  end
end
