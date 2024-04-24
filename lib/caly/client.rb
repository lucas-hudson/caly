module Caly
  class Client
    class << self
      attr_accessor :host, :token

      def headers
        {Authorization: "Bearer #{self.token}", "Content-Type": "application/json"}
      end

      def execute_request(method, path, body: nil)
        uri = URI.parse([self.host, path].join("/"))

        request = Net::HTTPGenericRequest.new(
          method.to_s.upcase,
          body ? true : false,
          true,
          uri,
          headers
        )

        request.body = body.to_json if body

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        return {"message" => "No Content", "code" => response.code} if response.is_a?(Net::HTTPNoContent)

        JSON.parse(response.body).merge("code" => response.code)
      end
    end
  end
end
