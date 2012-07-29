class ChangeUsersCodeToText < ActiveRecord::Migration
  def up
    change_column :notes, :code, :text
  end

  def down
    change_column :notes, :code, :string
  end
end
