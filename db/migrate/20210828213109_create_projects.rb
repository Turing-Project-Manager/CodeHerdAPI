class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :summary
      t.string :mod_number
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
