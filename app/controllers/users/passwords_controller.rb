# Lets a signed-in person use the emailed change-password link (Devise normally only allows
# password resets while signed out).
class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :require_no_authentication, only: %i[edit update]
end
