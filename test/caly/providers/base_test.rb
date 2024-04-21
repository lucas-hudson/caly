module Caly
  module Providers
    describe Base do
      def setup
        @base = Base.new("token")
      end

      describe "#initialize" do
        it "must delegate #execute_request to the client" do
          client = Minitest::Mock.new
          client.expect :execute_request, nil

          Caly::Client.stub :new, client do
            @base = Base.new("token")
            @base.execute_request
          end

          client.verify
        end
      end
    end
  end
end
