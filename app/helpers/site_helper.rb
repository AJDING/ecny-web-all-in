module SiteHelper
  # Inline style for <body>; inline beats Tailwind's font-sans so the choice applies everywhere.
  def site_font_style
    f = SiteSetting.font
    "font-family: #{f[:family]}; font-size: #{f[:size]}; line-height: #{f[:line_height]};"
  end
end
