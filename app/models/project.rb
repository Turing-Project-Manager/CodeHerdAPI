class Project < ApplicationRecord
  validates :name, presence: true
  validates :owner_id, presence: true
  validates :mod_number, presence: true
  # validates :summary, presence: true
  has_many :collaborators
  has_many :users, through: :collaborators
  has_many :resources
  has_many :project_repos

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', required: true
end
