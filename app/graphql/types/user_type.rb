module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :slack_handle, String, null: true
    field :github_handle, String, null: true
    field :working_styles, [String], null: true
    field :cohort, String, null: true
    field :pronouns, String, null: true
    # field :github_access_token, String, null: false
  end
end
