require 'rails_helper'

RSpec.describe 'Get A User', type: :request do
  before(:each) do
    @user = create(:user)
  end

  def query
    <<~GQL
    {
      user(id: #{@user.id}){
        id,
        email,
        githubHandle
      }
    }
    GQL
  end

  it 'should return a user' do
    post '/graphql', params: {query: query}
    expect(response.body).to include(@user.email)
    expect(response.body).to include(@user.id.to_s)
    expect(response.body).to include(@user.github_handle)
  end
end