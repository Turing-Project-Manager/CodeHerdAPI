require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'relationships' do
    it {should belong_to :owner}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner_id) }
    it { should validate_presence_of(:mod_number) }
    # it { should validate_presence_of(:summary) }
  end

  it 'should have a valid factory' do
    user = create(:user)
    expect(build(:project, owner: user)).to be_valid
  end
end
