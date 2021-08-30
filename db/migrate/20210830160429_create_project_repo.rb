class CreateProjectRepo < ActiveRecord::Migration[5.2]
  def change
    create_table :project_repos do |t|
      t.references :project, foreign_key: true
      t.string :repo_name

      t.timestamps
    end
  end
end
