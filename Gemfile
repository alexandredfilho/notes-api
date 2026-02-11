source "https://rubygems.org"

gem "rails", "~> 8.0.3"
gem "pg", ">= 1.5"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "rack-cors"
gem "jsonapi-serializer"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end

group :development do
  gem "bundler-audit", require: false
  gem "rubycritic", require: false
end
