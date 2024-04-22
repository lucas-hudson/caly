require "test_helper"

module Caly
  module Providers
    Caly::AVAILABLE_PROVIDERS.each do |provider_name|
      provider = Object.const_get("Caly::Providers::#{Util.classify(provider_name)}").new("token")

      describe provider.class do
        describe "#list_calendars" do
          describe "when successful" do
            it_lists_calendars(provider_name) do
              request = request_for(provider_name, :list_calendars)
              stub_request(:get, request[:path]).to_return_json(body: request[:body], status: request[:code])

              provider.list_calendars
            end
          end

          describe "when unsuccessful" do
            it_returns_an_error(provider_name) do
              provider.list_calendars
            end
          end
        end

        describe "#get_calendar" do
          id = rand(123)

          describe "when successful" do
            it_gets_calendar(provider_name) do
              request = request_for(provider_name, :get_calendar)
              stub_request(:get, [request[:path], id].join).to_return_json(body: request[:body], status: request[:code])

              provider.get_calendar(id)
            end
          end

          describe "when unsuccessful" do
            it_returns_an_error(provider_name) do
              provider.get_calendar(id)
            end
          end
        end

        describe "#create_calendar" do
          describe "when successful" do
            it_gets_calendar(provider_name) do
              request = request_for(provider_name, :create_calendar)
              stub_request(:post, request[:path]).to_return_json(body: request[:body], status: request[:code])

              provider.create_calendar(name: "test")
            end
          end

          describe "when unsuccessful" do
            it_returns_an_error(provider_name) do
              provider.create_calendar(name: "test")
            end
          end
        end

        describe "#update_calendar" do
          id = rand(123)

          describe "when successful" do
            it_gets_calendar(provider_name) do
              request = request_for(provider_name, :update_calendar)
              stub_request(:patch, [request[:path], id].join).to_return_json(body: request[:body], status: request[:code])

              provider.update_calendar(id: id, name: "test")
            end
          end

          describe "when unsuccessful" do
            it_returns_an_error(provider_name) do
              provider.update_calendar(id: id, name: "test")
            end
          end
        end
      end
    end
  end
end
