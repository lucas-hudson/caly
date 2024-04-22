require "simplecov"

SimpleCov.start { add_filter "/test/" }

require "shields_badge"
SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge

require "minitest/autorun"
require "webmock/minitest"
require "caly"
require "pry"

require "support/configuration_helpers"
require "support/request_helpers"

class Minitest::Mock
  # Suppress warnings that are shown when delegating methods to a Minitest::Mock
  def respond_to_missing?(symbol, include_private = false)
    @expected_calls.key? symbol.to_sym
  end
end
