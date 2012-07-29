class ChangeUsersCodeToText < ActiveRecord::Migration
  def up
    change_column :notes, :code, :text, :limit => 1023
  end

  def down
    change_column :notes, :code, :string
  end
end
