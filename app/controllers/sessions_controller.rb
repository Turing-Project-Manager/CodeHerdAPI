class SessionsController < ApplicationController
  # If you're using a strategy that POSTs during callback, you'll need to skip the authenticity token check for the callback action only. 
  # skip_before_action :verify_authenticity_token, only: :create

  # TODO: delete a user
  def new
    # This route is catched by the Omniauth Middleware and is invisible to rake routes
    # TODO: check if user is already in database
    redirect_to '/auth/github'
  end

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    json = {
      id: user.id,
      name: user.name,
      email: user.email,
    }.to_json
    # TODO: redirect to frontend
    redirect_to "http://localhost:3000/#{user.github_handle}?info=#{json}"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end