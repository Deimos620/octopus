Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.action_mailer.delivery_method = :smtp
  smtp_system = ENV['SMTP_SYSTEM'].downcase.to_sym
  puts "Configuring email for #{smtp_system}"
  config.action_mailer.smtp_settings = case smtp_system
    when :sendgrid
      {
        :address        => 'smtp.sendgrid.net',
        :port           => '587',
        :authentication => :plain,
        :user_name      => ENV['SENDGRID_USERNAME'],
        :password       => ENV['SENDGRID_PASSWORD'],
        :domain         => ENV['APPLICATION_WEB_HOSTNAME']
      }
    when :mailtrap
      # require 'rubygems' if RUBY_VERSION < '1.9'
      # require 'rest_client'
      # require 'json'
      response = RestClient.get "https://mailtrap.io/api/v1/inboxes.json?" +
        "api_token=#{ENV['MAILTRAP_API_TOKEN']}"
      first_inbox = JSON.parse(response)[0]
      {
        :user_name => first_inbox['username'],
        :password => first_inbox['password'],
        :address => first_inbox['domain'],
        :domain => first_inbox['domain'],
        :port => first_inbox['smtp_ports'][0],
        :authentication => :plain
      }
  end

  config.action_mailer.default_url_options = { :host => ENV['APPLICATION_WEB_HOSTNAME'] }
  ActionMailer::Base.default :from => Rails.application.config.email_from_address

  config.action_mailer.asset_host = ENV['APPLICATION_WEB_HOSTNAME'] 
  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like
  # NGINX, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.s3_credentials = {
    region: 'us-east-1',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }

  config.s3_bucket = "oct-" + (ENV['OCT_ENV'] || 'prod').downcase

  CarrierWave.configure do |carrierwave_config|
    carrierwave_config.fog_credentials = config.s3_credentials.merge({provider: 'AWS'})
    carrierwave_config.fog_directory = config.s3_bucket
    # https://gist.github.com/cblunt/1303386
    carrierwave_config.cache_dir = "#{Rails.root}/tmp/uploads"
    carrierwave_config.fog_public = true
  end

  # Look here to see how we're storing files
  config.carrierwave_storage = :fog

end
