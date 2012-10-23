class Note < ActiveRecord::Base

  attr_accessible :code, :code_tags, :description, :syntax_highlighted_code, :nonpublic
  attr_taggable :code_tags
  belongs_to :user

  before_save :highlight_code

  validates :description, presence: true
  validates :code, presence: true
  validates :user_id, presence: true

  default_scope order: 'notes.created_at DESC'

  has_many :comments, dependent: :destroy

  def self.from_users_followed_by(user, user_only = false, tag = nil)
    notes = user_only ? 
        where{user_id == user.id}
      : where{((user_id >> user.followed_user_ids) & (nonpublic == false)) | (user_id == user.id)}
    notes = tagged_with(tag) if tag
    notes
  end

  private

  def highlight_code
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay, :fenced_code_blocks => true)
    self.syntax_highlighted_code = markdown.render(self.code)
  end
end
