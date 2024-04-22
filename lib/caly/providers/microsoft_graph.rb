module Caly
  module Providers
    class MicrosoftGraph < Base
      def initialize(token)
        @url = "https://graph.microsoft.com/v1.0/me"
        super
      end

      def list_calendars
        response = execute_request(:get, "calendars")

        return error_from(response) unless response["code"] == "200"

        response["value"].map { |calendar| calendar_from(calendar) if calendar["canEdit"] == true }.compact
      end

      def get_calendar(id)
        response = execute_request(:get, "calendars/#{id}")

        return error_from(response) unless response["code"] == "200"

        calendar_from(response)
      end

      def create_calendar(name:, description: nil, location: nil, timezone: nil)
        response = execute_request(:post, "calendars", body: {name: name})

        return error_from(response) unless response["code"] == "201"

        calendar_from(response)
      end

      def update_calendar(id:, name: nil, description: nil, location: nil, timezone: nil)
        response = execute_request(:patch, "calendars/#{id}", body: {name: name}.compact)

        return error_from(response) unless response["code"] == "200"

        calendar_from(response)
      end

      def delete_calendar(id)
        response = execute_request(:delete, "calendars/#{id}")

        response["code"] == "204" || error_from(response)
      end

      private

      def calendar_from(response)
        Caly::Calendar.new(
          id: response["id"],
          name: response["name"],
          raw: response
        )
      end
      
      def error_from(response)
        ::Caly::Error.new(
          type: response.dig("error", "code"),
          message: response.dig("error", "message"),
          code: response.dig("code")
        )
      end
    end
  end
end
