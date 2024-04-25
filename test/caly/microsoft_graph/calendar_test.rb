require "test_helper"

module Caly
  describe MicrosoftGraph::Calendar do
    def setup
      @provider = MicrosoftGraph::Calendar
      Client.host = @provider::HOST
      Client.token = "token"
    end

    describe "#list" do
      describe "when successful" do
        it "must return an array of Caly::Calendar instances" do
          stub_request(
            :get, "https://graph.microsoft.com/v1.0/me/calendars"
          ).to_return_json(body: json_for(:microsoft_graph, :calendar, :list), status: 200)

          response = @provider.list

          assert response.is_a?(Array)
          assert response.sample.is_a?(Caly::Calendar)
          assert_equal "microsoft_graph_id", response.sample.id
          assert_equal "microsoft_graph_name", response.sample.name
        end
      end

      describe "when unsuccessful" do
        it_returns_an_error(:microsoft_graph) do
          @provider.list
        end
      end
    end

    describe "#get" do
      describe "when successful" do
        it "must return a Caly::Calendar instance" do
          id = rand(123)

          stub_request(
            :get, "https://graph.microsoft.com/v1.0/me/calendars/#{id}"
          ).to_return_json(body: json_for(:microsoft_graph, :calendar, :get), status: 200)

          response = @provider.get(id)

          assert response.is_a?(Caly::Calendar)
          assert_equal "microsoft_graph_id", response.id
          assert_equal "microsoft_graph_name", response.name
        end
      end

      describe "when unsuccessful" do
        it_returns_an_error(:microsoft_graph) do
          @provider.get("id")
        end
      end
    end

    describe "#create" do
      describe "when successful" do
        it "must return a Caly::Calendar instance" do
          stub_request(
            :post, "https://graph.microsoft.com/v1.0/me/calendars"
          ).to_return_json(body: json_for(:microsoft_graph, :calendar, :get), status: 201)

          response = @provider.create(name: "name")

          assert response.is_a?(Caly::Calendar)
          assert_equal "microsoft_graph_id", response.id
          assert_equal "microsoft_graph_name", response.name
        end
      end

      describe "when unsuccessful" do
        it_returns_an_error(:microsoft_graph) do
          @provider.create(name: "name")
        end
      end
    end
  end
end
