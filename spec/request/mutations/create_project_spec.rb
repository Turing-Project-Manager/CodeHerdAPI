require 'rails_helper'

RSpec.describe 'Create Project', type: :request do
  it 'create a new project' do
    def query(user_id, mod_number, summary, name)
      <<~GQL
      mutation {
        createProject(input:{
          owner: #{user_id}
          modNumber: #{mod_number},
          summary: #{summary},
          name: #{name}
        }
        ){
          project{
            id,
            owner,
            modNumber,
            summary,
            name
          }
          errors
        }
      }
      GQL
    end

    user_1 = User.create!(name: "Turing Kiddo", email: "sigh@turing.com", github_handle: "le_sigh", github_access_token: "jkshfkjshaqetyy4sesh8gzs9y")
    mod = "3"
    summary = "Best project ever, don't look at the bugs."
    name = "Hire me."
    post '/graphql', params: { query:  query(user_1.id, mod, summary, name) }

    parsed = JSON.parse(response.body, symbolize: true)

    expect(parsed[:data][:createProject][:project][:owner]).to be(user_1)
    expect(parsed[:data][:createProject][:project][:modNumber]).to eq(mod)
    expect(parsed[:data][:createProject][:project][:summary]).to eq(summary)
    expect(parsed[:data][:createProject][:project][:name]).to eq(name)

  end
end
