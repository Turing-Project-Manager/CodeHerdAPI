require 'rails_helper'

RSpec.describe 'query project', type: :request do
  it 'returns project name information' do
    user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
    project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103", owner_id: user.id)
    post '/graphql', params: { query: "{ project(id: #{project.id}) {name} }" }
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:project][:name]).to eq(project.name)
  end
end
