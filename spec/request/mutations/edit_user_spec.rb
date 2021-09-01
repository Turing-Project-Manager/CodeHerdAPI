require 'rails_helper'

RSpec.describe 'Get A User', type: :request do
  before(:each) do
    @user = create(:user)
  end

  def query(id)
    <<~GQL
      mutation {
        editUser(input:{
          userId: #{id},
          slackHandle: "@zach green",
          cohort: "2103"
        }
        ){
          user{
            id
            slackHandle
            cohort
          }
          errors
        }
      }
    GQL
  end

  it 'should edit and return user' do
    post '/graphql', params: {query: query(@user.id)}
    expect(response.body).to include(@user.id.to_s)
    expect(response.body).to include('@zach green')
    expect(response.body).to include('2103')
    json = JSON.parse response.body
    expect(json['data']['editUser']['errors']).to eq([])
  end

  it 'should have error if user does not exist' do
    post '/graphql', params: {query: query(0)}
    json = JSON.parse(response.body)
    expect(json['data']['editUser']['errors']).to include("Couldn't find User with 'id'=0")
  end
end