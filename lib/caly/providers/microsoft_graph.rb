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

        response["value"].map do |c|
          Caly::Calendar.new(id: c["id"], name: c["name"], raw: c) if c["canEdit"] == true
        end.compact
      end

      def get_calendar(id)
        res = execute_request(:get, "calendars/#{id}")

        return error_from(res) unless res["code"] == "200"

        Caly::Calendar.new(id: res["id"], name: res["name"], raw: res)
      end

      def create_calendar(name:, description: nil, location: nil, timezone: nil)
        res = execute_request(:post, "calendars", body: {name: name})

        return error_from(res) unless res["code"] == "201"

        Caly::Calendar.new(id: res["id"], name: res["name"])
      end

      private

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
