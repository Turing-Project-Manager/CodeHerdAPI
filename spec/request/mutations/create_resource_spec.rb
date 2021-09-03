require 'rails_helper'

RSpec.describe 'Create Resource', type: :request do
  before :all do
    @user = create(:user)
    @project = create(:project, owner: @user)
    Collaborator.create(user: @user, project: @project)
  end

  def query(user_id, project_id, resource_type, content, name, tags: [])
    <<~GQL
    mutation {
      createResource(input:{
        userId: #{user_id},
        projectId: #{project_id},
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

  describe 'create a resource' do
    it 'returns error if user is not collaborator' do
      post '/graphql', params: { query: query(0, @project.id, 'link', 'The Content', 'The Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:createResource][:errors][0]).to eq('Cant create resource. You are not a collaborator or project doesnt exist')
    end

    it 'creates a resource' do
      post '/graphql', params: { query: query(@user.id, @project.id, 'link', 'The Content', 'The Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:createResource][:resource]).to include(name: 'The Name', resourceType: 'link', content: 'The Content')
    end

    it 'creates a resource with tags' do
      post '/graphql', params: { query: query(@user.id, @project.id, 'link', 'The Content', 'The Name', tags: ['a', 'few', 'tags']) }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:createResource][:resource]).to include(name: 'The Name', resourceType: 'link', content: 'The Content', tags: ['a', 'few', 'tags'])
    end
  end

  describe 'create a resource with invalid input' do
    it 'returns error if name is not present' do
      post '/graphql', params: { query: query(@user.id, @project.id, 'link', 'The Content', '') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:createResource][:errors]).to include("Name can't be blank")
    end

    it 'returns error if resource type is not present' do
      post '/graphql', params: { query: query(@user.id, @project.id, '', 'The Content', 'Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:createResource][:errors][0]).to eq("Resource type can't be blank")
    end

    it 'returns error if content is not present' do
      post '/graphql', params: { query: query(@user.id, @project.id, 'link', '', 'Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:createResource][:errors][0]).to eq("Content can't be blank")
    end

    it 'returns error if resource type is not valid' do
      # if resource type is not link, file, or text
      post '/graphql', params: { query: query(@user.id, @project.id, 'path', 'Content', 'Name') }
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:createResource][:errors][0]).to eq("'path' is not a valid resource_type")
    end
  end
end
