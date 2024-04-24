module Foo
  module Providers
    module A
      class Calendar < Foo::Providers::Base
        URL = "https://www.googleapis.com/calendar/v3"

        class << self
          def list
            response = execute_request(:get, "/calendar_path")

            Foo::Calendar.new
          end
        end
      end
    end
  end
end
