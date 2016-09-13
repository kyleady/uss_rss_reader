require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UssRssReader
  class Application < Rails::Application # :nodoc:
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_job.queue_adapter = :sucker_punch

    config.after_initialize do
      FeedsUpdateJob.perform_async(continuous: true, all: true)
    end
  end
end
