# require "test_helper"
#
# module Caly
#   [AVAILABLE_PROVIDERS.first].each do |provider_name|
#
#     def setup
#       Client.host = "https://www.googleapis.com/calendar/v3"
#       Client.token = "token"
#       @provider = GoogleOauth2::Calendar
#     end
#
#     describe provider.name do
#       describe "#list" do
#         describe "when successful" do
#           it "must return an array of Calendar instances" do
#             response = stub_request(
#               :get, "https://www.googleapis.com/calendar/v3/users/me/calendarList"
#             ).to_return_json(body: json_for(provider_name, :list_calendars), status: 200)
#
#             provider.list
#
#             assert response.is_a?(Array)
#             assert response.sample.is_a?(Caly::Calendar)
#             assert_equal "#{provider}_id", response.sample.id
#             assert_equal "#{provider}_name", response.sample.name
#           end
#         end
#
#         # describe "when unsuccessful" do
#         #   it_returns_an_error(provider_name) do
#         #     provider.list_calendars
#         #   end
#         # end
#       end
#     end
#   end
# end
