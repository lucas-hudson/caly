module Caly
  module MicrosoftGraph
    class Calendar < Caly::Calendar
      HOST = "https://graph.microsoft.com/v1.0/me"

      class << self
        def list
          response = Caly::Client.execute_request(:get, "calendars")

          return error_from(response) unless response["code"] == "200"

          response["value"].map { |calendar| calendar_from(calendar) if calendar["canEdit"] }.compact
        end

        def get(id)
          response = Caly::Client.execute_request(:get, "calendars/#{id}")

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def create(name:, description: nil, location: nil, timezone: nil)
          response = Caly::Client.execute_request(:post, "calendars", body: {name: name})

          return error_from(response) unless response["code"] == "201"

          calendar_from(response)
        end

        def update(id:, name: nil, description: nil, location: nil, timezone: nil)
          response = Caly::Client.execute_request(:patch, "calendars/#{id}", body: {name: name}.compact)

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def delete(id)
          response = Caly::Client.execute_request(:delete, "calendars/#{id}")

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
end
