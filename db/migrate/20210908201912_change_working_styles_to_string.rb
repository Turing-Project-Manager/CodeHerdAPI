class ChangeWorkingStylesToString < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :working_styles, :string
  end
end
