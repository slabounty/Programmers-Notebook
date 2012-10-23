class Comment < ActiveRecord::Base
  belongs_to :note
  belongs_to :user

  attr_accessible :comment, :user

  validates :comment, presence: true
  validates :note_id, presence: true
  validates :user_id, presence: true

  default_scope order: 'comments.created_at DESC'

end
