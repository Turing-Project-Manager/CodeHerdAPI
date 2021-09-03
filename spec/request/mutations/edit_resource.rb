require 'rails_helper'

RSpec.describe 'Edit Resource', type: :request do
  before :all do
    @user = create(:user)
    @project = create(:project, owner: @user)
    Collaborator.create(user: @user, project: @project)
    @resource = create(:resource, project: @project)
  end

  def query(user_id, resource_type, content, name, tags: [])
    <<~GQL
    mutation {
      editResource(input:{
        userId: #{user_id},
        projectId: #{@project.id},
        resourceId: #{@resource.id}
        resourceType: "#{resource_type}",
        content: "#{content}",
        name: "#{name}",
        tags: #{tags}
      }
      ){
        resource{
          name
          resourceType,
          content
          tags
        }
        errors
      }
    }
    GQL
  end

  describe 'edit a resource' do
    it 'returns error if user is not collaborator' do
      post '/graphql', params: { query: query(0,'link', 'The Content', 'The Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:errors][0]).to eq('Cant create resource. You are not a collaborator or project doesnt exist')
    end

    it 'edit' do
      post '/graphql', params: { query: query(@user.id, 'link', 'The Content', 'The Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:resource]).to include(name: 'The Name', resourceType: 'link', content: 'The Content')
      expect(parsed[:data][:editResource][:resource][:name]).to_not eq(@resource.name)
    end

    it 'can remove tags' do
      post '/graphql', params: { query: query(@user.id, 'link', 'The Content', 'The Name', tags: ['a', 'tag']) }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:resource]).to include(tags: ['a', 'tag'])
      post '/graphql', params: { query: query(@user.id, 'link', 'The Content', 'The Name', tags: []) }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:resource]).to include(tags: [])
    end
  end

  describe 'edit a resource with invalid input' do
    it 'returns error if name is not present' do
      post '/graphql', params: { query: query(@user.id, 'link', 'The Content', '') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:errors]).to include("Name can't be blank")
    end

    it 'returns error if resource type is not present' do
      post '/graphql', params: { query: query(@user.id, '', 'The Content', 'Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:errors][0]).to eq("Resource type can't be blank")
    end

    it 'returns error if content is not present' do
      post '/graphql', params: { query: query(@user.id, 'link', '', 'Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:errors][0]).to eq("Content can't be blank")
    end

    it 'returns error if resource type is not valid' do
      # if resource type is not link, file, or text
      post '/graphql', params: { query: query(@user.id, 'path', 'Content', 'Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:editResource][:errors][0]).to eq("'path' is not a valid resource_type")
    end
  end
end
