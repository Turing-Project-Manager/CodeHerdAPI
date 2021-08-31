class AddTypeAndContentColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :resource_type, :integer
    add_column :resources, :content, :text
  end
end
