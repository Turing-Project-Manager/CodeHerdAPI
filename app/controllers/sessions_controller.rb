class SessionsController < ApplicationController
  # If you're using a strategy that POSTs during callback, you'll need to skip the authenticity token check for the callback action only. 
  # skip_before_action :verify_authenticity_token, only: :create

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    json = {
      id: user.id,
      name: user.name,
      email: user.email,
      image: user.image
    }.to_json
    # TODO: redirect to frontend
    redirect_to "https://codeherd.herokuapp.com/#{user.github_handle}?info=#{json}"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
