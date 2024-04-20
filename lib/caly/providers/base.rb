module Caly
  module Providers
    class Base
      def initialize(token)
        @headers = {"Authorization": "Bearer #{token}", "ContentType": "application/json"}
      end

      private

      def execute_request(method, path)
        uri = URI.parse([@url, path].join("/"))

        request = Net::HTTPGenericRequest.new(
          method.to_s.upcase,
          false,
          true,
          uri,
          @headers
        )

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        JSON.parse(response.body).merge(code: response.code).with_indifferent_access
      end

      def error_from(response)
        ::Caly::Error.new(message: response.dig(:error, :message), code: response.dig(:code))
      end

      def successful?(code)
        Rack::Utils::HTTP_STATUS_CODES[code.to_i] == "OK"
      end
    end
  end
end