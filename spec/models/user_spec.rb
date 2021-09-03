require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:github_handle)}
  it {should validate_presence_of(:github_access_token)}
  it {should validate_uniqueness_of(:github_handle)}
  it {should validate_uniqueness_of(:github_access_token)}
  # it {should validate_presence_of(:slack_handle)}
  # it {should validate_presence_of(:cohort)}
  it {should have_many(:projects)}

  it 'should have a valid factory' do
    expect(build(:user)).to be_valid
  end
end