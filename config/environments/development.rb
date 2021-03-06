Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Show errors is HTML formatl
  config.debug_exception_response_format = :default

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :readthis_store, {
        expires_in: 24.hours.to_i,
        redis: { url: "#{ENV['REDIS_URL']}/0/cache", driver: :hiredis }
    }
    config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=172800' }
  else
    config.action_controller.perform_caching = false
    config.cache_store = [:null_store]
  end

  # Fake email server
  config.action_mailer.delivery_method     = :file
  config.action_mailer.file_settings       = { :location => Rails.root.join('tmp/mail') }
  config.action_mailer.default_url_options = { :host => "http://localhost:3000" }

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Better errors
  # TODO fix issue with better error
  # BetterErrors::Middleware.allow_ip! "0.0.0.0/0"

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
