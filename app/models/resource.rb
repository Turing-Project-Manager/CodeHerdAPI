class Resource < ApplicationRecord
  validates :name, presence: true
  validates :resource_type, presence: true
  validates :content, presence: true
  belongs_to :project

  enum resource_type: [:link, :text, :file]
end
