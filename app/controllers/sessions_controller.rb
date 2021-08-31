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
    str = [user.id.to_s, user.name, user.email].to_s
    encoded_token = Base64.encode64(str)

    # TODO: redirect to frontend
    redirect_to "/?token=#{encoded_token}"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
