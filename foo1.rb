require "pry"

require_relative "foo1/util"
require_relative "foo1/base"
require_relative "foo1/calendar"
require_relative "foo1/providers/base"
require_relative "foo1/providers/a/calendar"
require_relative "foo1/providers/b/calendar"

module Foo
  AVAILABLE_PROVIDERS = [:a, :b].freeze
end
