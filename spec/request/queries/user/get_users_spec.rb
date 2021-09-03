require 'rails_helper'

RSpec.describe 'Get Users', type: :request do
  before(:each) do
    Resource.destroy_all
    Collaborator.destroy_all
    Project.destroy_all
    User.destroy_all
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

  xit 'should return all users' do
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