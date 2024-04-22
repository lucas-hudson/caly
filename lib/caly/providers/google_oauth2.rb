module Caly
  module Providers
    class GoogleOauth2 < Base
      def initialize(token)
        @url = "https://www.googleapis.com/calendar/v3"
        super
      end

      def list_calendars
        res = execute_request(:get, "users/me/calendarList")

        return error_from(res) unless res["code"] == "200"

        res["items"].map do |c|
          if c["accessRole"] == "owner"
            Caly::Calendar.new(
              id: c["id"],
              name: c["summary"],
              description: c["description"],
              location: c["location"],
              timezone: c["timeZone"],
              raw: c
            )
          end
        end.compact
      end

      def create_calendar(name:, description: nil, location: nil, timezone: nil)
        res = execute_request(:post, "calendars", body: {
          summary: name,
          description: description,
          location: location,
          timeZone: timezone
        })

        return error_from(res) unless res["code"] == "200"

        Caly::Calendar.new(
          id: res["id"],
          name: res["summary"],
          description: res["description"],
          location: res["location"],
          timezone: res["timeZone"]
        )
      end

      private

      def error_from(response)
        ::Caly::Error.new(
          type: response.dig("error", "errors")&.first&.dig("message"),
          message: response.dig("error", "message"),
          code: response.dig("code")
        )
      end
    end
  end
end
