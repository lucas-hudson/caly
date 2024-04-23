module Caly
  module Providers
    module GoogleOauth2
      class Calendar < Caly::Providers::Base
        URL = "https://www.googleapis.com/calendar/v3"

        class << self
          def list
            response = execute_request(:get, "users/me/calendarList")
            3.times.map { |c| Caly::Calendar.new(id: c, name: "Google Calendar") }
          end
        end
      end
    end
  end
end
