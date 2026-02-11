require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
