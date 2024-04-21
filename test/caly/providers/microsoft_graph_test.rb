module Caly
  module Providers
    describe MicrosoftGraph do
      def setup
        @url = "https://graph.microsoft.com/v1.0/me"
        @microsoft_graph = MicrosoftGraph.new("token")
      end

      describe "#list_calendars" do
        describe "when successful" do
          it_lists_calendars(:microsoft_graph, "calendars") do
            @microsoft_graph.list_calendars
          end
        end

        describe "when unsuccessful" do
          it_returns_an_error(:microsoft_graph) do
            @microsoft_graph.list_calendars
          end
        end
      end
    end
  end
end
