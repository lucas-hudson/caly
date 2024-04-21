require "test_helper"

module Caly
  describe Util do
    def setup
      @util = Util
    end

    describe "#classify" do
      it "must classify a string" do
        assert_equal "HamAndEggs", @util.classify("ham_and_eggs")
        assert_equal "GoogleOauth2", @util.classify("google_oauth2")
        assert_equal "MicrosoftGraph", @util.classify("microsoft_graph")
      end
    end
  end
end
