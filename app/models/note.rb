class Note < ActiveRecord::Base

  attr_accessible :code, :code_tags, :description, :syntax_highlighted_code, :nonpublic
  attr_taggable :code_tags
  belongs_to :user

  before_save :highlight_code

  validates :description, presence: true
  validates :code, presence: true
  validates :user_id, presence: true

  default_scope order: 'notes.created_at DESC'

  def self.from_users_followed_by(user)
    where{((user_id >> user.followed_user_ids) & (nonpublic == false)) | (user_id == user.id)}
  end

  private

  def highlight_code
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay, :fenced_code_blocks => true)
    self.syntax_highlighted_code = markdown.render(self.code)
  end
end
