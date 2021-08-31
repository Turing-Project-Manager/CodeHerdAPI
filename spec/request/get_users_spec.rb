require 'rails_helper'

RSpec.describe 'Get Users', type: :request do
  before(:each) do
    @users = create_list(:user, 5)
  end

  def query
    <<~GQL
    {
      users{
        id,
        email,
        githubHandle
      }
    }
    GQL
  end

  it 'should return all users' do
    post '/graphql', params: {query: query}
    json = JSON.parse(response.body)
    expect(json['data']['users'].count).to eq(5)
    @users.each do |user|
      expect(response.body).to include(user.email)
      expect(response.body).to include(user.id.to_s)
      expect(response.body).to include(user.github_handle)
    end
  end
end