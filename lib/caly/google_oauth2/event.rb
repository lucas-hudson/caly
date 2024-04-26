module Caly
  module GoogleOauth2
    class Event < Base
      class << self
        def list(calendar_id: "primary", starts_at: nil, ends_at: nil)
          response = Caly::Client.execute_request(
            :get,
            "calendars/#{calendar_id}/events",
            params: {timeMin: starts_at.utc.strftime('%FT%TZ'), timeMax: ends_at.utc.strftime('%FT%TZ')}.compact
          )

          return error_from(response) unless response["code"] == "200"

          response["items"].map { |event| event_from(calendar_id, event) }
        end

        def get(calendar_id: "primary", id:)
          response = Caly::Client.execute_request(:get, "calendars/#{calendar_id}/events/#{id}")

          return error_from(response) unless response["code"] == "200"

          event_from(calendar_id, response)
        end

        def create(
          starts_at:, start_time_zone:, ends_at:, end_time_zone:, calendar_id: "primary", name: nil, description: nil,
          location: nil
        )
          response = Caly::Client.execute_request(
            :post,
            "calendars/#{calendar_id}/events",
            body: Util.compact_blank({
              summary: name,
              description: description,
              location: location,
              start: {
                dateTime: starts_at.utc.strftime('%FT%TZ'),
                timeZone: start_time_zone,
              },
              end: {
                dateTime: ends_at.utc.strftime('%FT%TZ'),
                timeZone: end_time_zone,
              }
            }))

          return error_from(response) unless response["code"] == "200"

          event_from(calendar_id, response)
        end

        def update(
          calendar_id: "primary", id:, starts_at: nil, start_time_zone: nil, ends_at: nil, end_time_zone: nil,
          name: nil, description: nil, location: nil
        )
          response = Caly::Client.execute_request(
            :patch,
            "calendars/#{calendar_id}/events/#{id}",
            body: Util.compact_blank({
              summary: name,
              description: description,
              location: location,
              start: {
                dateTime: starts_at&.utc&.strftime('%FT%TZ'),
                timeZone: start_time_zone,
              }.compact,
              end: {
                dateTime: ends_at&.utc&.strftime('%FT%TZ'),
                timeZone: end_time_zone,
              }.compact
            }))

          return error_from(response) unless response["code"] == "200"

          event_from(calendar_id, response)
        end

        def delete(calendar_id: "primary", id:)
          response = Caly::Client.execute_request(:delete, "calendars/#{calendar_id}/events/#{id}")

          response["code"] == "204" || error_from(response)
        end

        private

        def event_from(calendar_id, response)
          Caly::Event.new(
            id: response["id"],
            calendar_id: calendar_id,
            name: response["summary"],
            description: response["description"],
            all_day: response.dig("start", "dateTime").nil?,
            starts_at: response.dig("start", "date") || response.dig("start", "dateTime"),
            start_time_zone: response.dig("start", "timeZone"),
            ends_at: response.dig("end", "date") || response.dig("end", "dateTime"),
            end_time_zone: response.dig("end", "timeZone"),
            attendees: response["attendees"] || [],
            location: response["location"],
            created: response["created"],
            raw: response
          )
        end
      end
    end
  end
end
