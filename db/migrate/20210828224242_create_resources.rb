class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :tags, :array => true, :default => []
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
