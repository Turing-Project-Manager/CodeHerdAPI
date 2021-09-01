require 'rails_helper'

RSpec.describe 'Get A User', type: :request do
  before(:each) do
    @user = create(:user)
  end

  def query(user_id: nil)
    user_id ||= @user.id
    <<~GQL
    {
      user(id: #{user_id}){
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

  it 'should return error if user is not found' do
    post '/graphql', params: {query: query(user_id: 0)}
    expect(response.body).to include("Couldn't find User with 'id'=0")
  end
  
end