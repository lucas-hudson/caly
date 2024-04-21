module Caly
  module Providers
    class GoogleOauth2 < Base
      def initialize(token)
        @url = "https://www.googleapis.com/calendar/v3"
        super
      end

      def list_calendars
        response = execute_request(:get, "users/me/calendarList")

        return error_from(response) unless response["code"] == "200"

        response["items"].map do |c|
          if c["accessRole"] == "owner"
            Caly::Calendar.new(id: c["id"], name: c["summary"], description: c["description"], location: c["location"], timezone: c["timeZone"], raw: c)
          end
        end.compact
      end
    end
  end
end
