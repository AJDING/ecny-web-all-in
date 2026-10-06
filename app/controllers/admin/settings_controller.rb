class Admin::SettingsController < Admin::BaseController
  def show
    @font = SiteSetting.font_key
  end

  def update
    font = params.dig(:settings, :font).to_s
    if SiteSetting::FONTS.key?(font)
      SiteSetting.put("font", font)
      redirect_to admin_settings_path, notice: "Site font set to #{SiteSetting::FONTS[font][0]}."
    else
      redirect_to admin_settings_path, alert: "Unknown font choice."
    end
  end
end
