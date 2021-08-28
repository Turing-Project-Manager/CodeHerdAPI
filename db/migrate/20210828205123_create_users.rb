class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :slack_handle
      t.string :github_handle
      t.string :working_styles, :array => true, :default => []
      t.string :cohort
      t.string :pronouns
      t.string :github_access_token

      t.timestamps
    end
  end
end
