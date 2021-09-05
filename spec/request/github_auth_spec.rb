require 'rails_helper'

RSpec.describe 'GithubAuth', type: :request do
  before :each do 
    OmniAuth.config.mock_auth[:github] = Faker::Omniauth.github
  end

  it 'should create a user' do
    count = User.count
    get '/auth/github'
    follow_redirect!
    expect(User.count).to eq(count + 1)
  end
end