require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'relationships' do
    it {should belong_to :project}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:resource_type) }
    it { should validate_presence_of(:content) }
  end

  it 'does not create resource w/o a project' do
    resource = Resource.create(name: 'test', resource_type: :link, content: 'test')
    expect(resource.errors.full_messages).to eq(['Project must exist'])
  end

  it 'should have a valid factory' do
    expect(build(:resource)).to be_valid
  end
end
