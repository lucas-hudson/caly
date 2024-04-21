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

        response[:"value"].map do |c|
          Caly::Calendar.new(id: c["id"], name: c["name"], raw: c) if c["canEdit"] == true
        end.compact
      end
    end
  end
end
