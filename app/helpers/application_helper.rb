module ApplicationHelper
end

# create a custom renderer that allows highlighting of code blocks
class HTMLwithCodeRay < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.scan(code, language).div(:line_numbers => :inline)
  end
end

