require "test_helper"

module Caly
  describe Calendar do
    def setup
      @calendar = Calendar.new(id: "id", name: "name", description: "description", location: "location", timezone: "timezone", raw: "raw")
    end

    describe "#initialize" do
      it "must respond to id" do
        assert @calendar.respond_to?(:id)
      end

      it "must respond to name" do
        assert @calendar.respond_to?(:name)
      end

      it "must respond to description" do
        assert @calendar.respond_to?(:description)
      end

      it "must respond to location" do
        assert @calendar.respond_to?(:location)
      end

      it "must respond to timezone" do
        assert @calendar.respond_to?(:timezone)
      end

      it "must respond to raw" do
        assert @calendar.respond_to?(:raw)
      end
    end
  end
end
