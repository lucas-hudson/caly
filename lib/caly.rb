module Caly
  AVAILABLE_PROVIDERS = [:google_oauth2, :microsoft_graph].freeze
end

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

Caly::AVAILABLE_PROVIDERS.each do |provider|
  require "caly/#{provider}/calendar"
end

