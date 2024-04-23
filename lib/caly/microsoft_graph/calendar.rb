module Caly
  module MicrosoftGraph
    class Calendar < Caly::Calendar
      URL = "https://graph.microsoft.com/v1.0/me"

      class << self
        def list
          response = execute_request(:get, "calendars")
          p response
          3.times.map { |c| superclass.new(id: c, name: "Microsoft Calendar") }
        end
      end
    end
  end
end
