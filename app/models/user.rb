class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :github_handle, presence: true, uniqueness: true
  validates :github_access_token, presence: true, uniqueness: true
  # validates :slack_handle, presence: true
  # validates :cohort, presence: true
  has_many :projects, dependent: :destroy, foreign_key: :owner_id

  def self.find_or_create_from_auth_hash(hash)
    info = hash[:info]
    github_handle = info[:nickname]
    email = info[:email]
    name = info[:name]
    github_access_token = hash[:credentials][:token]
    image = info[:image]
    # uid = hash[:uid]
    user = User.find_or_create_by(email: email)
    user.update(github_handle: github_handle, name: name, github_access_token: github_access_token, image: image)
    user
  end
end