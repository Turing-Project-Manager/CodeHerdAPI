require 'rails_helper'

RSpec.describe 'query project', type: :request do
  describe 'project information' do
    xit 'can find all projects for a user' do

    end

    it 'returns project name information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)
      post '/graphql', params: { query: "{ project(id: #{project.id}) {name} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:project][:name]).to eq(project.name)
    end

    it 'returns project summary information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)
      post '/graphql', params: { query: "{ project(id: #{project.id}) {summary} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:project][:summary]).to eq(project.summary)
    end

    it 'returns project mod_number information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)
      post '/graphql', params: { query: "{ project(id: #{project.id}) {modNumber} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:project][:modNumber]).to eq(project.mod_number)
    end

    it 'returns project owner id information' do
      user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
      project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)
      post '/graphql', params: { query: "{ project(id: #{project.id}) {owner {id}} }" }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:project][:owner][:id]).to eq("#{project.owner.id}")
    end
  end
end
