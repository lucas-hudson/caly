require "pry"

require_relative "foo/util"
require_relative "foo/base"
require_relative "foo/calendar"
require_relative "foo/providers/base"
require_relative "foo/providers/a/calendar"
require_relative "foo/providers/b/calendar"

module Foo
  AVAILABLE_PROVIDERS = [:a, :b].freeze
end
