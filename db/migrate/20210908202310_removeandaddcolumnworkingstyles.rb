class Removeandaddcolumnworkingstyles < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :working_styles
    add_column :users, :working_styles, :string
  end
end
