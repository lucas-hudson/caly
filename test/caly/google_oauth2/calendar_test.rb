require "test_helper"

module Caly
  describe GoogleOauth2::Calendar do
    def setup
      @provider = GoogleOauth2::Calendar
      Client.host = @provider::HOST
      Client.token = "token"
    end

    describe "#list" do
      describe "when successful" do
        it "must return an array of Caly::Calendar instances" do
          stub_request(
            :get, "https://www.googleapis.com/calendar/v3/users/me/calendarList"
          ).to_return_json(body: json_for(:google_oauth2, :calendar,:list), status: 200)

          response = @provider.list

          assert response.is_a?(Array)
          assert response.sample.is_a?(Caly::Calendar)
          assert_equal "google_oauth2_id", response.sample.id
          assert_equal "google_oauth2_name", response.sample.name
        end
      end

      describe "when unsuccessful" do
        it_returns_an_error(:google_oauth2) do
          @provider.list
        end
      end
    end

    describe "#get" do
      describe "when successful" do
        it "must return a Caly::Calendar instance" do
          id = rand(123)

          stub_request(
            :get, "https://www.googleapis.com/calendar/v3/calendars/#{id}"
          ).to_return_json(body: json_for(:google_oauth2, :calendar, :get), status: 200)

          response = @provider.get(id)

          assert response.is_a?(Caly::Calendar)
          assert_equal "google_oauth2_id", response.id
          assert_equal "google_oauth2_name", response.name
        end
      end

      describe "when unsuccessful" do
        it_returns_an_error(:google_oauth2) do
          @provider.get("id")
        end
      end
    end

    describe "#create" do
      describe "when successful" do
        it "must return a Caly::Calendar instance" do
          stub_request(
            :post, "https://www.googleapis.com/calendar/v3/calendars"
          ).to_return_json(body: json_for(:google_oauth2, :calendar, :get), status: 200)

          response = @provider.create(name: "name")

          assert response.is_a?(Caly::Calendar)
          assert_equal "google_oauth2_id", response.id
          assert_equal "google_oauth2_name", response.name
        end
      end

      describe "when unsuccessful" do
        it_returns_an_error(:google_oauth2) do
          @provider.create(name: "name")
        end
      end
    end
  end
end
