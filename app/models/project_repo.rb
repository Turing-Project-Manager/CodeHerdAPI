class ProjectRepo < ApplicationRecord
  validates :repo_name, presence: true
  belongs_to :project
end