require 'rails_helper'

RSpec.describe ProjectRepo, type: :model do
  it { should belong_to(:project) }
  it { should validate_presence_of(:repo_name) }
  it { should validate_uniqueness_of(:repo_name).scoped_to(:project_id) }

  it 'should have a valid factory' do
    expect(build(:project_repo)).to be_valid
  end
end