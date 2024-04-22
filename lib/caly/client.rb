module Caly
  class Client
    def initialize(url, headers)
      @url = url
      @headers = headers
    end

    def execute_request(method, path, body: nil)
      uri = URI.parse([@url, path].join("/"))

      request = Net::HTTPGenericRequest.new(
        method.to_s.upcase,
        body ? true : false,
        true,
        uri,
        @headers
      )

      request.body = body.to_json if body

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      JSON.parse(response.body).merge("code" => response.code)
    end
  end
end
