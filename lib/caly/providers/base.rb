module Caly
  module Providers
    class Base
      extend Forwardable

      def_delegator :@client, :execute_request

      def initialize(token)
        @headers = {Authorization: "Bearer #{token}", "Content-type": "application/json"}
        @client = Caly::Client.new(@url, @headers)
      end
    end
  end
end
