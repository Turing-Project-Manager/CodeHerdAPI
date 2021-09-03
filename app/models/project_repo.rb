class ProjectRepo < ApplicationRecord
  validates :repo_name, presence: true, uniqueness: {scope: :project_id}
  belongs_to :project
end