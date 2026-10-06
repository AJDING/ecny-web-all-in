class SiteSetting < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  # Font choices offered in Admin → Settings. Key => [label, CSS font-family stack]
  FONTS = {
    "times"   => ["Times New Roman (serif)", "'Times New Roman', Times, Georgia, serif"],
    "manrope" => ["Manrope (sans-serif, the original)", "Manrope, ui-sans-serif, system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif"]
  }.freeze
  DEFAULT_FONT = "times".freeze

  def self.fetch(key, default = nil)
    Rails.cache.fetch("site_setting/#{key}", expires_in: 5.minutes) { find_by(key: key)&.value } || default
  end

  def self.put(key, value)
    record = find_or_initialize_by(key: key)
    record.update!(value: value)
    Rails.cache.delete("site_setting/#{key}")
    record
  end

  def self.font_key    = FONTS.key?(fetch("font")) ? fetch("font") : DEFAULT_FONT
  def self.font_family = FONTS[font_key][1]
end
