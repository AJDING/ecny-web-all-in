Devise.setup do |config|
  config.mailer_sender = ENV.fetch("MAIL_FROM", "All In <allin@encounterny.com>")
  require "devise/orm/active_record"
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true                     # email change is pending until the new address confirms
  config.confirm_within = 3.days                  # confirmation link validity
  config.send_email_changed_notification = true   # tell the OLD address its email was changed
  config.send_password_change_notification = true # tell the account its password was changed
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
