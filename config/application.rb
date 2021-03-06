require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Reasontogive
  class Application < Rails::Application
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    config.time_zone = 'Central Time (US & Canada)'

    # handle 404/422 in routes
    config.exceptions_app = self.routes

    # for URLs in mailers
    config.action_mailer.default_url_options = { host: 'reasontogive.com' }
  end
end
