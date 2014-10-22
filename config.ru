Bundler.require
require "securerandom"
require "pghero/engine"
require "rails_12factor"
require "rails/all"

class PGHeroSolo < Rails::Application
  routes.append do
    mount PgHero::Engine, at: ENV['MOUNTPOINT'] || "/"
  end

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = true
  config.secret_token = ENV['SECRET_KEY_BASE'] || SecureRandom.hex(30)
end

PGHeroSolo.initialize!
run PGHeroSolo
