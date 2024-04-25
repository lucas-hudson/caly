require "test_helper"

module Caly
  describe Account do
    def setup
      @provider = AVAILABLE_PROVIDERS.first
      @account = Account.new(@provider, "token")
    end

    [:Calendar].each do |resource|
      describe "#delegation to the #{resource} class" do
        [:list, :get, :create].each do |method|
          it "must call #{method}" do
            Caly.const_get("#{Util.classify(@provider)}::#{resource}").stub(method, "foo") do
              assert_equal @account.send(:"#{method}_#{resource}"), "foo"
            end
          end
        end
      end
    end
  end
end
