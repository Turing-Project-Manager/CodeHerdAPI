require 'rails_helper'

RSpec.describe 'query project' do
  it 'returns project name information' do
    user = User.create!(name: "Turing Kiddo", email: "turing@turing.com", github_handle: "turing", github_access_token: "jkshfkjshauig47tyw49t8gzs9y")
    project = Project.create!(name: "My project", summary: "This is my project summary", mod_number: "2103",  owner: user.id)

    post '/graphql', params: { query: Project {name} }
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to eq({ "data": { "name": project.name }})
  end
end
