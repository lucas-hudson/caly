require "net/http"
require "json"

require "caly/providers/base"
require "caly/providers/google_oauth2"
require "caly/providers/microsoft_graph"

require "caly/account"
require "caly/calendar"
require "caly/error"

module Caly
  AVAILABLE_PROVIDERS = [:google_oauth2, :microsoft_graph].freeze
end