class SiteSetting < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  # Font choices offered in Admin → Settings.
  # key => { label:, family:, size:, line_height: }  (size/line_height apply to body text; headings keep their own sizes)
  FONTS = {
    "claude"  => { label: "Claude-style serif (Georgia, 16px / 1.5)",
                   family: "Georgia, 'Times New Roman', Times, serif", size: "16px", line_height: "1.5" },
    "times"   => { label: "Times New Roman (serif)",
                   family: "'Times New Roman', Times, Georgia, serif", size: "16px", line_height: "1.5" },
    "manrope" => { label: "Manrope (sans-serif, the original)",
                   family: "Manrope, ui-sans-serif, system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif", size: "16px", line_height: "1.5" }
  }.freeze
  DEFAULT_FONT = "claude".freeze

  def self.fetch(key, default = nil)
    Rails.cache.fetch("site_setting/#{key}", expires_in: 5.minutes) { find_by(key: key)&.value } || default
  end

  def self.put(key, value)
    record = find_or_initialize_by(key: key)
    record.update!(value: value)
    Rails.cache.delete("site_setting/#{key}")
    record
  end

  def self.font_key = FONTS.key?(fetch("font")) ? fetch("font") : DEFAULT_FONT
  def self.font     = FONTS[font_key]
end
