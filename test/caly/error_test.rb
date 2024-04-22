require "test_helper"

module Caly
  describe Error do
    def setup
      @error = Error.new(type: "type", message: "message", code: "code")
    end

    describe "#initialize" do
      it "must respond to type" do
        assert @error.respond_to?(:type)
      end

      it "must respond to message" do
        assert @error.respond_to?(:message)
      end

      it "must respond to code" do
        assert @error.respond_to?(:code)
      end
    end
  end
end
