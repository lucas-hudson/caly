require "simplecov"
require "shields_badge"

SimpleCov.start { add_filter "/test/" }
SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge

require "minitest/autorun"
require "webmock/minitest"
require "minitest/stub_const"
require "caly"

require "support/request_helpers"
