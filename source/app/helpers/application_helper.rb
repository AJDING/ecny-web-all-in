module ApplicationHelper
  # Minimal Markdown-lite for lesson bodies written by non-developers:
  # blank line = new paragraph, "## " = heading, "- " = bullet, **bold**.
  def render_body(text)
    return "" if text.blank?
    html = text.strip.split(/\n{2,}/).map do |block|
      block = ERB::Util.html_escape(block).gsub(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
      if block.start_with?("## ")
        "<h3>#{block.delete_prefix('## ')}</h3>"
      elsif block.lines.all? { |l| l.start_with?("- ") }
        "<ul>#{block.lines.map { |l| "<li>#{l.delete_prefix('- ').strip}</li>" }.join}</ul>"
      elsif block.start_with?("&gt; ")
        "<blockquote>#{block.delete_prefix('&gt; ').gsub("\n", '<br>')}</blockquote>"
      else
        "<p>#{block.gsub("\n", '<br>')}</p>"
      end
    end.join
    html.html_safe
  end

  def status_pill(status)
    case status
    when :complete then tag.span("Complete", class: "pill pill-done")
    when :current  then tag.span("Continue", class: "pill pill-go")
    else                tag.span("Locked",   class: "pill pill-lock")
    end
  end

  def page_title(title = nil)
    content_for(:title) { title } if title
    [content_for(:title), "All In · #{settings[:church_name]}"].compact.join(" · ")
  end
end
