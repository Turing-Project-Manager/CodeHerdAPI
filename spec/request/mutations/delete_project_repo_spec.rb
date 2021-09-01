require 'rails_helper'

RSpec.describe 'Delete Project Repo', type: :request do

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
        deleteProjectRepo(
          input: {
            userId: #{user_id}
            projectId: #{project_id}
            repoName: "#{repo_name}"
          }) {
            errors
          }
        }
    GQL
  end

  it 'should delete a project repo' do
    project_repo = ProjectRepo.create!(project: @project, repo_name: 'test_repo')
    post '/graphql', params: { query: query('test_repo') }
    expect {ProjectRepo.find(project_repo.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end

  it 'should have error if project repo does not exist' do
    post '/graphql', params: { query: query('test_repo') }
    expect(response.body).to include('could not find project repo')
  end

  it 'should not delete a project repo if project does not exist' do
    post '/graphql', params: { query: query('test_repo', project_id: 0) }
    expect(response.body).to include('Project does not exist or the user is not a collaborator')
  end

  it 'should not delete a project repo if user is not a collaborator' do
    post '/graphql', params: { query: query('test_repo', user_id: 0) }
    expect(response.body).to include('Project does not exist or the user is not a collaborator')
  end

end