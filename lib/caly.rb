require "net/http"
require "json"
require "forwardable"
require "pry"

require "caly/providers/base"
require "caly/providers/google_oauth2/calendar"
require "caly/providers/microsoft_graph/calendar"

require "caly/base"
require "caly/calendar"
require "caly/client"
require "caly/error"
require "caly/util"
require "caly/version"

module Caly
  AVAILABLE_PROVIDERS = [:google_oauth2, :microsoft_graph].freeze
end
