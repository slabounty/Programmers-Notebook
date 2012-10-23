class Comment < ActiveRecord::Base
  belongs_to :note

  attr_accessible :comment

  validates :comment, presence: true
  validates :note_id, presence: true

  def user
    note.user
  end
end
