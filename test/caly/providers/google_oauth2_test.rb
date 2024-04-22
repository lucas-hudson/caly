require "test_helper"

module Caly
  module Providers
    describe GoogleOauth2 do
      def setup
        @url = "https://www.googleapis.com/calendar/v3"
        @google_oauth2 = GoogleOauth2.new("token")
      end

      describe "#list_calendars" do
        describe "when successful" do
          it_lists_calendars(:google_oauth2) do
            json = json_response_for(:google_oauth2, "list_calendars")
            stub_request(:get, [@url, "/users/me/calendarList"].join).to_return_json(body: json, status: 200)

            @google_oauth2.list_calendars
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:google_oauth2) do
            @google_oauth2.list_calendars
          end
        end
      end

      describe "#create_calendar" do
        describe "when successful" do
          it_creates_calendar(:google_oauth2) do
            json = json_response_for(:google_oauth2, "create_calendar")
            stub_request(:post, [@url, "/calendars"].join).to_return_json(body: json, status: 200)

            @google_oauth2.create_calendar(name: "test")
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:google_oauth2) do
            @google_oauth2.create_calendar(name: "test")
          end
        end
      end
    end
  end
end
