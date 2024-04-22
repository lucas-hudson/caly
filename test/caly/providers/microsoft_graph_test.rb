require "test_helper"

module Caly
  module Providers
    describe MicrosoftGraph do
      def setup
        @url = "https://graph.microsoft.com/v1.0/me"
        @microsoft_graph = MicrosoftGraph.new("token")
      end

      describe "#list_calendars" do
        describe "when successful" do
          it_lists_calendars(:microsoft_graph) do
            json = json_response_for(:microsoft_graph, "list_calendars")
            stub_request(:get, [@url, "/calendars"].join).to_return_json(body: json, status: 200)

            @microsoft_graph.list_calendars
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:microsoft_graph) do
            @microsoft_graph.list_calendars
          end
        end
      end

      describe "#get_calendar" do
        id = rand(123)

        describe "when successful" do
          it_gets_calendar(:microsoft_graph) do
            json = json_response_for(:microsoft_graph, "get_calendar")
            stub_request(:get, [@url, "/calendars/#{id}"].join).to_return_json(body: json, status: 200)

            @microsoft_graph.get_calendar(id)
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:microsoft_graph) do
            @microsoft_graph.get_calendar(id)
          end
        end
      end

      describe "#create_calendar" do
        describe "when successful" do
          it_gets_calendar(:microsoft_graph) do
            json = json_response_for(:microsoft_graph, "get_calendar")
            stub_request(:post, [@url, "/calendars"].join).to_return_json(body: json, status: 201)

            @microsoft_graph.create_calendar(name: "test")
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:microsoft_graph) do
            @microsoft_graph.create_calendar(name: "test")
          end
        end
      end

      describe "#update_calendar" do
        id = rand(123)

        describe "when successful" do
          it_gets_calendar(:microsoft_graph) do
            json = json_response_for(:microsoft_graph, "get_calendar")
            stub_request(:patch, [@url, "/calendars/#{id}"].join).to_return_json(body: json, status: 200)

            @microsoft_graph.update_calendar(id: id, name: "test")
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:microsoft_graph) do
            @microsoft_graph.update_calendar(id: id, name: "test")
          end
        end
      end
    end
  end
end
