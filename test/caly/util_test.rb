require "test_helper"

module Caly
  describe Util do
    def setup
      @util = Util
    end

    describe "#classify" do
      it "must classify a string" do
        assert_equal "HamAndEggs", @util.classify("ham_and_eggs")
      end
    end
  end
end
