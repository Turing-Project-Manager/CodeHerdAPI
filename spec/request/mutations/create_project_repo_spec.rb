require 'rails_helper'

RSpec.describe 'Create Project Repo', type: :request do
  before :all do
    @user = create(:user)
    @project = create(:project, owner: @user)
    Collaborator.create!(user: @user, project: @project)
  end

  def query(repo_name, user_id: nil, project_id: nil)
    user_id ||= @user.id
    project_id ||= @project.id
    <<~GQL
      mutation {
        createProjectRepo(
          input: {
            userId: #{user_id}
            projectId: #{project_id}
            repoName: "#{repo_name}"
          }) {
            projectRepo {
              id,
              repoName
            },
            errors
          }
        }
    GQL
  end

  it 'should create a project repo' do
    post '/graphql', params: { query: query('test_repo') }
    body = JSON.parse(response.body)
    data = body['data']['createProjectRepo']['projectRepo']
    expect(data['repoName']).to eq('test_repo')
  end

  it 'should not create a project repo if project does not exist' do
    post '/graphql', params: { query: query('test_repo', project_id: 0) }
    body = JSON.parse(response.body)
    data = body['data']['createProjectRepo']['projectRepo']
    errors = body['data']['createProjectRepo']['errors']
    expect(data).to eq(nil)
    expect(errors).to include('Project does not exist or the user is not a collaborator')
  end

  it 'should not create a project repo if user is not a collaborator' do
    @user = create(:user)
    post '/graphql', params: { query: query('test_repo', user_id: @user.id) }
    body = JSON.parse(response.body)
    data = body['data']['createProjectRepo']['projectRepo']
    errors = body['data']['createProjectRepo']['errors']
    expect(data).to eq(nil)
    expect(errors).to include('Project does not exist or the user is not a collaborator')
  end

  it 'can not create two repos with the same name on the same project' do
    post '/graphql', params: { query: query('test_repo') }
    post '/graphql', params: { query: query('test_repo') }
    body = JSON.parse(response.body)
    data = body['data']['createProjectRepo']['projectRepo']
    errors = body['data']['createProjectRepo']['errors']
    expect(data).to eq(nil)
    expect(errors).to include('Repo name has already been taken')
  end

end