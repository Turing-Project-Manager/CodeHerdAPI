OmniAuth.config.allowed_request_methods = %i[get post]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           ENV['GITHUB_KEY'],
           ENV['GITHUB_SECRET'],
           scope: 'user,repo,gist'
end
