module Caly
  module GoogleOauth2
    class Event < Caly::Event
      HOST = "https://www.googleapis.com/calendar/v3"

      class << self
        def list(calendar_id: nil, starts_at: nil, ends_at:)
          response = Caly::Client.execute_request(
            :get,
            "calendars/#{calendar_id}/events",
            params: {timeMin: starts_at.utc.strftime('%FT%TZ'), timeMax: ends_at.utc.strftime('%FT%TZ')}.compact
          )

          return error_from(response) unless response["code"] == "200"

          response["items"].map { |event| event_from(calendar_id, event) }
        end

        def get(id)
          response = Caly::Client.execute_request(:get, "calendars/#{id}")

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def create(
          starts_at:, start_time_zone:, ends_at:, end_time_zone:, calendar_id: "primary", name: nil, description: nil,
          location: nil, transparent: false, status: :confirmed
        )
          response = Caly::Client.execute_request(:post, "calendars/#{calendar_id}/events", body: {
            summary: name,
            description: description,
            location: location,
            start: {
              dateTime: starts_at,
              timeZone: start_time_zone,
            },
            end: {
              dateTime: ends_at,
              timeZone: end_time_zone,
            },
            transparency: transparent ? "transparent" : "opaque",
            status: status
          })

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def update(id: nil, name: nil, description: nil, location: nil, timezone: nil)
          response = Caly::Client.execute_request(:patch, "calendars/#{id}", body: {
            summary: name,
            description: description,
            location: location,
            timeZone: timezone
          }.compact)

          return error_from(response) unless response["code"] == "200"

          calendar_from(response)
        end

        def delete(id)
          response = Caly::Client.execute_request(:delete, "calendars/#{id}")

          response["code"] == "204" || error_from(response)
        end

        private

        def event_from(calendar_id, response)
          superclass.new(
            id: response["id"],
            calendar_id: calendar_id,
            name: response["summary"],
            description: response["description"],
            all_day: response.dig("start", "dateTime").nil?,
            starts_at: response.dig("start", "date") || response.dig("start", "dateTime"),
            start_time_zone: response.dig("start", "timeZone"),
            ends_at: response.dig("end", "date") || response.dig("end", "dateTime"),
            end_time_zone: response.dig("end", "timeZone"),
            creator: response["creator"],
            attendees: response["attendees"] || [],
            location: response["location"],
            use_default_reminder: response.dig("reminders", "useDefault"),
            reminders: response.dig("reminders", "overrides") || [],
            transparent: !response["transparency"].nil?,
            status: response["status"],
            created: response["created"],
            updated: response["updated"],
            raw: response
          )
        end

        def error_from(response)
          Caly::Error.new(
            type: response.dig("error", "errors")&.first&.dig("message"),
            message: response.dig("error", "message"),
            code: response.dig("code")
          )
        end
      end
    end
  end
end
