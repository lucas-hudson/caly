module Caly
  module GoogleOauth2
    class Calendar < Caly::Calendar
      URL = "https://www.googleapis.com/calendar/v3"

      class << self
        def list
          response = execute_request(:get, "users/me/calendarList")
          p response
          3.times.map { |c| superclass.new(id: c, name: "Google Calendar") }
        end

        def get(id)
          response = execute_request(:get, "users/me/calendarList/#{id}")
          p response
          superclass.new(id: id, name: "Google Calendar")
        end

        def create(name:, description: nil)
          response = execute_request(:get, "users/me/calendarList")
          p response
          superclass.new(name: name)
        end
      end
    end
  end
end
