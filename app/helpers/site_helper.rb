module SiteHelper
  # Inline style for <body>; inline beats Tailwind's font-sans so the choice applies everywhere.
  def site_font_style
    "font-family: #{SiteSetting.font_family};"
  end
end
