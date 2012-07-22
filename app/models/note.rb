class Note < ActiveRecord::Base
  attr_accessible :code, :description
  belongs_to :user

  validates :description, presence: true
  validates :code, presence: true
  validates :user_id, presence: true

  default_scope order: 'notes.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
