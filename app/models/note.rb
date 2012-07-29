class Note < ActiveRecord::Base
  attr_accessible :code, :description, :syntax_highlighted_code
  belongs_to :user

  before_save :highlight_code

  validates :description, presence: true
  validates :code, presence: true
  validates :user_id, presence: true

  default_scope order: 'notes.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)

    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  private

  def highlight_code
    # HACK - for now we'll just set the code with pre/code in place.
    # syntax_highlighted_code = "<pre><code>" + code + "</code></pre>"
    self.syntax_highlighted_code = CodeRay.scan(code, :ruby).div(:line_numbers => :inline)
  end
end
