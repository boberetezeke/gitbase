require_relative 'boot'

require 'rails/all'
require 'rails-viewmodel'
require 'rails-form'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gitbase
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.opal.source_map_enabled = false
  end
end
