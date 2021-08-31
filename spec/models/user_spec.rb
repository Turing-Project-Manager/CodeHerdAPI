require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:github_handle) }
  it { should validate_presence_of(:github_access_token) }
  it { should validate_uniqueness_of(:github_handle) }
  it { should validate_uniqueness_of(:github_access_token) }
end
