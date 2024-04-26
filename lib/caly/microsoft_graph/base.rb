module Caly
  module MicrosoftGraph
    class Base
      HOST = "https://graph.microsoft.com/v1.0/me"

      class << self
        private

        def error_from(response)
          ::Caly::Error.new(
            type: response.dig("error", "code"),
            message: response.dig("error", "message"),
            code: response.dig("code")
          )
        end
      end
    end
  end
end
