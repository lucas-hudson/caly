module Caly
  module Providers
    class Base
      extend Forwardable

      def_delegator :@client, :execute_request

      def initialize(token)
        @headers = {"Authorization": "Bearer #{token}", "ContentType": "application/json"}
        @client = Caly::Client.new(@url, @headers)
      end

      private

      def error_from(response)
        ::Caly::Error.new(message: response.dig("error", "message"), code: response.dig("code"))
      end
    end
  end
end
