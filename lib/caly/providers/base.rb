module Caly
  module Providers
    class Base
      class << self
        attr_accessor :token

        def headers
          {Authorization: "Bearer #{token}", "Content-Type": "application/json"}
        end

        def execute_request(method, path, body: nil)
          Caly::Client.new(self::URL, headers).execute_request(method, path, body: body)
        end
      end
    end
  end
end
