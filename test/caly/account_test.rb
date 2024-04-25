# require "test_helper"
#
# module Caly
#   describe Account do
#     def setup
#       @account = Account.new(AVAILABLE_PROVIDERS.sample, "token")
#     end
#
#     describe "#initialize" do
#       it "must have a provider" do
#         assert @account.provider
#       end
#
#       it "must have a token" do
#         assert @account.token
#       end
#
#       it "must validate the provider" do
#         Account.new("unknown_provider", "token")
#       rescue => e
#         assert_equal e.class, ArgumentError
#       end
#     end
#
#     describe "#self.caly_provider_for" do
#       AVAILABLE_PROVIDERS.each do |provider|
#         it "must return the correct #{provider} class" do
#           assert @account.class.caly_provider_for(provider), "Caly::Providers::#{Util.classify(provider)}".constantize
#         end
#       end
#     end
#
#     describe "#caly_provider" do
#       AVAILABLE_PROVIDERS.each do |provider|
#         @account = Account.new(provider, "token")
#
#         it "must return the correct #{provider} instance" do
#           assert @account.caly_provider, "Caly::Providers::#{Util.classify(provider)}".constantize.new(@account.token)
#         end
#       end
#     end
#
#     describe "#list_calendars" do
#       AVAILABLE_PROVIDERS.each do |provider|
#         it "must call #list_calendars from the #{Util.classify(provider)} instance" do
#           provider_instance = Minitest::Mock.new
#           provider_instance.expect :list_calendars, nil
#
#           Providers.const_get(Util.classify(provider)).stub :new, provider_instance do
#             @account = Account.new(provider, "token")
#             @account.list_calendars
#           end
#
#           provider_instance.verify
#         end
#       end
#     end
#   end
# end
