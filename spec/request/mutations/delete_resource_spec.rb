require 'rails_helper'

RSpec.describe 'Delete Resource', type: :request do
  before :each do
    @user = create(:user)
    @project = create(:project, owner: @user)
    Collaborator.create(user: @user, project: @project)
    @resource = create(:resource, project: @project)
  end

  def query(id, resource_id: nil)
    resource_id ||= @resource.id
    <<~GQL
    mutation {
      deleteResource(input:{
        userId: #{id},
        projectId: #{@project.id},
        resourceId: #{resource_id}
      }
      ){errors}
    }
    GQL
  end

  it 'should not delete resource if user is not collaborator' do
    count = Resource.count
    post '/graphql', params: { query: query(0) }
    expect(Resource.count).to eq(count)
  end

  it 'should delete resource if user is collaborator' do
    count = Resource.count
    post '/graphql', params: { query: query(@user.id) }
    expect(Resource.count).to eq(count - 1)
  end

  it 'should return error if resource does not exist' do
    post '/graphql', params: { query: query(@user.id, resource_id: 0) }
    errors = JSON.parse(response.body)['data']['deleteResource']['errors']
    expect(errors).to include('Resource not found')
  end
end