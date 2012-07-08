class Note < ActiveRecord::Base
  attr_accessible :code, :description
  belongs_to :user

  validates :description, presence: true
  validates :code, presence: true
  validates :user_id, presence: true

  default_scope order: 'notes.created_at DESC'
end
