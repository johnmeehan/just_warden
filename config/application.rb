# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

require_relative '../lib/warden/strategies/token_strategy'
require_relative '../lib/warden/strategies/set_response_token'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JustWarden
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # load the code in the lib folder
    config.autoload_paths += %W[#{config.root}/lib]
    config.middleware.use Warden::Manager do |manager|
      manager.default_strategies :token

      # any thing that responds to .call will work!
      #   this just returns a response like object when called.
      #   [HttpStatusCode, Header, [ Body ]]
      manager.failure_app = ->(_env) { ['401', { 'Content-Type' => 'application/json' }, [{ error: 'Failure app: Unauthorized', code: 401 }.to_json]] }
    end

    config.middleware.use Warden::Strategies::SetResponseToken
  end
end
