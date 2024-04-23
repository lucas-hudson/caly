require "pry"
require "forwardable"

module Caly
  module APIOperations
    def execute_request(params)
      p "response from #{self.class.name} with #{params}"

      { id: rand(123) }
    end
  end

  class Account
    attr_reader :provider

    def initialize(provider, token)
      @provider = provider
      @token = token
    end
  end

  class Base
    extend Forwardable

    def_delegators :adapter, :who_am_i, :list

    def initialize(account)
      @account = account
    end

    def adapter
      @adapter ||= Object.const_get("Caly::#{@account.provider}::#{self.class.name.split("::").last}").new
    end

    def response_class
      @response_class ||= Object.const_get("Caly::Response::#{self.class.name.split("::").last}")
    end
  end

  class Calendar < Base
    def initialize(account)
      super
    end
  end

  class Event < Base
    def initialize(account)
      super
    end
  end

  module A
    class Calendar
      include Caly::APIOperations

      def who_am_i
        "Calendar A"
      end

      def list
        response = execute_request("Calendar A params")

        Caly::Response::Calendar.new(id: response[:id])
      end
    end

    class Event
      include Caly::APIOperations

      def who_am_i
        "Event A"
      end

      def list
        response = execute_request("Event A params")

        Caly::Response::Event.new(id: response[:id])
      end
    end
  end

  module B
    class Calendar
      include Caly::APIOperations

      def who_am_i
        "Calendar B"
      end

      def list
        response = execute_request("Calendar B params")

        Caly::Response::Calendar.new(id: response[:id])
      end
    end

    class Event
      include Caly::APIOperations

      def who_am_i
        "Event B"
      end

      def list
        response = execute_request("Event B params")

        Caly::Response::Event.new(id: response[:id])
      end
    end
  end

  module Response
    class Calendar
      def initialize(id: nil, name: nil)
        @id = id
        @name = name
      end
    end

    class Event
      def initialize(id: nil, location: nil)
        @id = id
        @location = location
      end
    end
  end
end

# Provider A
account_a = Caly::Account.new("A", "token")

calendar_a = Caly::Calendar.new(account_a)
p "Get calendars list for Provider A"
p calendar_a.list
puts ""

p "Get events list for Provider A"
event_a = Caly::Event.new(account_a)
p event_a.list
puts ""

# Provider B
account_b = Caly::Account.new("B", "token")

p "Get calendars list for Provider B"
calendar_b = Caly::Calendar.new(account_b)
p calendar_b.list
puts ""

p "Get events list for Provider B"
event_b = Caly::Event.new(account_b)
p event_b.list
