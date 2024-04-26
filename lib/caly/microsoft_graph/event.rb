module Caly
  module MicrosoftGraph
    class Event < Base
      class << self
        def list(calendar_id: nil, starts_at: nil, ends_at: nil)
          response = Caly::Client.execute_request(
            :get,
            "#{handle_calendar_id(calendar_id)}/calendarView",
            params: {
              startDateTime: starts_at&.utc&.strftime("%FT%TZ"), endDateTime: ends_at&.utc&.strftime("%FT%TZ"), top: 1000
            }
          )

          return error_from(response) unless response["code"] == "200"

          response["value"].map { |event| event_from(calendar_id, event) }
        end

        def get(id:, calendar_id: nil)
          response = Caly::Client.execute_request(
            :get,
            "#{handle_calendar_id(calendar_id)}/events/#{id}"
          )

          return error_from(response) unless response["code"] == "200"

          event_from(calendar_id, response)
        end

        def create(
          starts_at:, start_time_zone:, ends_at:, end_time_zone:, calendar_id: nil, name: nil, description: nil,
          location: nil
        )
          response = Caly::Client.execute_request(
            :post,
            "#{handle_calendar_id(calendar_id)}/events",
            body: Util.compact_blank({
              subject: name,
              description: description,
              location: {displayName: location}.compact,
              start: {
                dateTime: starts_at.utc.strftime("%FT%TZ"),
                timeZone: start_time_zone
              },
              end: {
                dateTime: ends_at.utc.strftime("%FT%TZ"),
                timeZone: end_time_zone
              }
            })
          )

          return error_from(response) unless response["code"] == "201"

          event_from(calendar_id, response)
        end

        def update(
          id:, calendar_id: nil, starts_at: nil, start_time_zone: nil, ends_at: nil, end_time_zone: nil, name: nil,
          description: nil, location: nil
        )
          response = Caly::Client.execute_request(
            :patch,
            "#{handle_calendar_id(calendar_id)}/events/#{id}",
            body: Util.compact_blank({
              subject: name,
              description: description,
              location: location,
              start: {
                dateTime: starts_at&.utc&.strftime("%FT%TZ"),
                timeZone: start_time_zone
              }.compact,
              end: {
                dateTime: ends_at&.utc&.strftime("%FT%TZ"),
                timeZone: end_time_zone
              }.compact
            })
          )

          return error_from(response) unless response["code"] == "200"

          event_from(calendar_id, response)
        end

        def delete(id:, calendar_id: nil)
          response = Caly::Client.execute_request(
            :delete,
            "#{handle_calendar_id(calendar_id)}/events/#{id}"
          )

          response["code"] == "204" || error_from(response)
        end

        private

        def event_from(calendar_id, response)
          Caly::Event.new(
            id: response["id"],
            calendar_id: calendar_id,
            name: response["subject"],
            description: response["bodyPreview"],
            all_day: response.dig("isAllDay"),
            starts_at: Time.parse(response.dig("start", "dateTime")),
            start_time_zone: response.dig("start", "timeZone"),
            ends_at: Time.parse(response.dig("end", "dateTime")),
            end_time_zone: response.dig("end", "timeZone"),
            attendees: response["attendees"],
            location: response.dig("location", "displayName"),
            created: Time.parse(response["createdDateTime"]),
            raw: response
          )
        end

        def handle_calendar_id(id)
          id ? "calendars/#{id}" : "calendar"
        end
      end
    end
  end
end
