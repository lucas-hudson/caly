module Caly
  module Providers
    module MicrosoftGraph
      class Calendar < Caly::Providers::Base
        URL = "https://graph.microsoft.com/v1.0/me"

        class << self
          def list(token)
            self.token = token
            response = execute_request(:get, "calendars")
            p response
            3.times.map { |c| Caly::Calendar.new(id: c, name: "Microsoft Calendar") }
          end
        end
      end
    end
  end
end
