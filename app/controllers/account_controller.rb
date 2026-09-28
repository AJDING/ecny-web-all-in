class AccountController < ApplicationController
    # "Change password" on Account Settings: send the signed-in person a reset link (10-minute expiry)
  # instead of asking for the old password on the page.
  def password_link
    current_user.send_password_change_link
    redirect_to edit_user_registration_path,
                                notice: "We emailed a password-change link to #{current_user.email}. It expires in 10 minutes."
  end
end
