require "active_support/core_ext/integer/time"
Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = true
  config.active_storage.service = :r2
  # Cloudflare terminates TLS and proxies to the app; keep SSL on (Full (strict) mode in Cloudflare).
  config.assume_ssl = true
  config.force_ssl = true
  config.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new($stdout))
  config.log_tags = [:request_id]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: ENV.fetch("APP_HOST", "allin.encounterny.com"), protocol: "https" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV["SMTP_ADDRESS"], port: ENV.fetch("SMTP_PORT", 587).to_i,
    user_name: ENV["SMTP_USERNAME"], password: ENV["SMTP_PASSWORD"],
    authentication: :plain, enable_starttls_auto: true
  }
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  config.hosts = [ENV.fetch("APP_HOST", "allin.encounterny.com"), /.*\.onrender\.com/, /.*\.fly\.dev/]
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
