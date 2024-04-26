module Caly
  module GoogleOauth2
    class Base
      HOST = "https://www.googleapis.com/calendar/v3"

      class << self
        private

        def error_from(response)
          Caly::Error.new(
            type: response.dig("error", "errors")&.first&.dig("message"),
            message: response.dig("error", "message"),
            code: response.dig("code")
          )
        end
      end
    end
  end
end
