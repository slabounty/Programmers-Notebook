class AddNonPublicToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :nonpublic, :boolean, default: false

  end
end
