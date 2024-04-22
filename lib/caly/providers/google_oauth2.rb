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

        response["items"].map { |calendar| calendar_from(calendar) if calendar["accessRole"] == "owner" }.compact
      end

      def get_calendar(id)
        response = execute_request(:get, "calendars/#{id}")

        return error_from(response) unless response["code"] == "200"

        calendar_from(response)
      end

      def create_calendar(name:, description: nil, location: nil, timezone: nil)
        response = execute_request(:post, "calendars", body: {
          summary: name,
          description: description,
          location: location,
          timeZone: timezone
        })

        return error_from(response) unless response["code"] == "200"

        calendar_from(response)
      end

      def update_calendar(id:, name: nil, description: nil, location: nil, timezone: nil)
        response = execute_request(:patch, "calendars/#{id}", body: {
          summary: name,
          description: description,
          location: location,
          timeZone: timezone
        }.compact)

        return error_from(response) unless response["code"] == "200"

        calendar_from(response)
      end

      private

      def calendar_from(response)
        Caly::Calendar.new(
          id: response["id"],
          name: response["summary"],
          description: response["description"],
          location: response["location"],
          timezone: response["timeZone"],
          raw: response
        )
      end

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
