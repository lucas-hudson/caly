module Foo
  module Providers
    class Base
      class << self
        attr_accessor :token

        def headers
          {Authorization: "Bearer #{token}", "Content-Type": "application/json"}
        end

        def execute_request(method, path, body: nil)
          p self::URL, headers, method, path
        end
      end
    end
  end
end
