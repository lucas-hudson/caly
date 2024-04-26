module Caly
  module GoogleOauth2
    class Calendar < Base
      class << self
        def list
          response = Caly::Client.execute_request(:get, "users/me/calendarList")

          return error_from(response) unless response["code"] == "200"

          response["items"].map { |calendar| calendar_from(calendar) if calendar["accessRole"] == "owner" }.compact
        end

        def get(id:)
          response = Caly::Client.execute_request(:get, "calendars/#{id}")

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def create(name:, description: nil, location: nil, timezone: nil)
          response = Caly::Client.execute_request(:post, "calendars", body: {
            summary: name,
            description: description,
            location: location,
            timeZone: timezone
          })

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def update(id:, name: nil, description: nil, location: nil, timezone: nil)
          response = Caly::Client.execute_request(:patch, "calendars/#{id}", body: {
            summary: name,
            description: description,
            location: location,
            timeZone: timezone
          }.compact)

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def delete(id:)
          response = Caly::Client.execute_request(:delete, "calendars/#{id}")

          response["code"] == "204" || error_from(response)
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
      end
    end
  end
end
