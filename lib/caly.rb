require "net/http"
require "json"
require "forwardable"
require "pry"

require "caly/base"
require "caly/calendar"
require "caly/client"
require "caly/error"
require "caly/util"
require "caly/version"

require "caly/google_oauth2/calendar"
require "caly/microsoft_graph/calendar"

module Caly
  AVAILABLE_PROVIDERS = [:google_oauth2, :microsoft_graph].freeze
end
