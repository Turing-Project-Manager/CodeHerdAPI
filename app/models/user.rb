class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :github_handle, presence: true, uniqueness: true
  validates :github_access_token, presence: true, uniqueness: true

  def self.find_or_create_from_auth_hash(hash)
    github_handle = hash[:info][:nickname]
    email = hash[:info][:email]
    name = hash[:info][:name]
    github_access_token = hash[:credentials][:token]
    # image = hash[:info][:image]
    # uid = hash[:uid]
    user = User.find_or_create_by(email: email)
    user.update(github_handle: github_handle, name: name, github_access_token: github_access_token)
    user
  end
end