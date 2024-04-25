require "simplecov"

SimpleCov.start { add_filter "/test/" }

require "shields_badge"
SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge

require "minitest/autorun"
require "webmock/minitest"
require "minitest/stub_const"
require "caly"

require "support/configuration_helpers"
require "support/request_helpers"
