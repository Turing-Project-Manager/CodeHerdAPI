require 'rails_helper'

RSpec.describe 'Create Project', type: :request do
  it 'create a new project' do
    def query(user_id, mod_number, summary, name)
      <<~GQL
      mutation {
        createProject(input:{
          ownerId: #{user_id}
          modNumber: "#{mod_number}",
          summary: "#{summary}",
          name: "#{name}"
        }
        ){
          project{
            id,
            modNumber,
            summary,
            name,
            owner {
              id
            }
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
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:createProject][:project][:owner][:id].to_i).to be(user_1.id)
    expect(parsed[:data][:createProject][:project][:modNumber]).to eq(mod)
    expect(parsed[:data][:createProject][:project][:summary]).to eq(summary)
    expect(parsed[:data][:createProject][:project][:name]).to eq(name)
  end

  it 'send an error if a new project was not created' do
    def query(user_id, mod_number, name)
      <<~GQL
      mutation {
        createProject(input:{
          ownerId: #{user_id}
          modNumber: "#{mod_number}",
          name: "#{name}"
        }
        ){
          project{
            id,
            modNumber,
            summary,
            name,
            owner {
              id
            }
          }
          errors
        }
      }
      GQL
    end

    user_1 = User.create!(name: "Turing Kiddo", email: "sigh@turing.com", github_handle: "le_sigh", github_access_token: "jkshfkjshaqetyy4sesh8gzs9y")
    mod = "3"
    name = "Hire me."

    post '/graphql', params: { query:  query(user_1.id, mod, name) }
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:errors][0][:message]).to eq("Argument 'summary' on InputObject 'CreateProjectInput' is required. Expected type String!")
  end
end
