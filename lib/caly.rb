module Caly
  AVAILABLE_PROVIDERS = [:google_oauth2, :microsoft_graph].freeze
end

require "net/http"
require "json"
require "time"
require "pry"

require "caly/base"
require "caly/calendar"
require "caly/event"
require "caly/client"
require "caly/error"
require "caly/util"
require "caly/version"

require "caly/account"

Caly::AVAILABLE_PROVIDERS.each do |provider|
  require "caly/#{provider}/base"
  require "caly/#{provider}/calendar"
  require "caly/#{provider}/event"
end
