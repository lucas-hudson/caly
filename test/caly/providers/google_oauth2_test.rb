module Caly
  module Providers
    describe GoogleOauth2 do
      def setup
        @url = "https://www.googleapis.com/calendar/v3"
        @google_oauth2 = GoogleOauth2.new("token")
      end

      describe "#list_calendars" do
        describe "when successful" do
          it_lists_calendars(:google_oauth2, "users/me/calendarList") do
            @google_oauth2.list_calendars
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:google_oauth2) do
            @google_oauth2.list_calendars
          end
        end
      end
    end
  end
end
