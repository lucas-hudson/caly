require "test_helper"

module Caly
  describe Account do
    def setup
      @account = Account.new(@provider, "token")
    end

    [:calendar, :event].each do |resource|
      describe "#delegation to the #{resource.capitalize} class" do
        Caly.const_get(Util.classify(resource))::METHODS.each do |method|
          it "must call #{method}" do
            Caly.const_get(Util.classify(resource)).stub(method, "foo") do
              assert_equal @account.public_send(:"#{method}_#{resource}"), "foo"
            end
          end
        end
      end
    end
  end
end
