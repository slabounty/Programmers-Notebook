class AddSyntaxHighlightedCodeToNote < ActiveRecord::Migration
  def change
    add_column :notes, :syntax_highlighted_code, :text

  end
end
