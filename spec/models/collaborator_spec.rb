require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :project}
  end

  describe 'validations' do
    it {should validate_presence_of(:user_id)}
    # it {should validate_uniqueness_of(:user_id)}
    it {should validate_presence_of(:project_id)}
    # it {should validate_uniqueness_of(:project_id)}
  end
end
