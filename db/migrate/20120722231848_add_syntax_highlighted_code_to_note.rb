class AddSyntaxHighlightedCodeToNote < ActiveRecord::Migration
  def change
    add_column :notes, :syntax_highlighted_code, :text, :limit => 2047

  end
end
