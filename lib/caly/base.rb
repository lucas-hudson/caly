module Caly
  class Base
    class << self
      attr_accessor :token

      OBJECTS = [:calendar, :event].freeze
      METHODS = [:list, :get, :create].freeze

      private

      def headers
        {Authorization: "Bearer #{token}", "Content-Type": "application/json"}
      end

      def execute_request(method, path, body: nil)
        Caly::Client.new(self::URL, headers).execute_request(method, path, body: body)
      end

      def caly_provider_for(provider)
        raise ArgumentError.new("Unknown provider") unless AVAILABLE_PROVIDERS.include?(provider.to_sym)
        Caly.const_get("#{Util.classify(provider)}::#{name.split("::").last}")
      end

      def method_missing(symbol, *args)
        super unless METHODS.include?(symbol) && OBJECTS.include?(name.gsub("Caly::", "").downcase.to_sym)

        provider, token, opts = *args

        caly_provider_for(provider).token = token
        call_provider_method(provider, symbol, opts)
      end

      def call_provider_method(provider, symbol, opts)
        if opts.is_a?(String)
          caly_provider_for(provider).public_send(symbol, opts)
        else
          caly_provider_for(provider).public_send(symbol, **(opts || {}))
        end
      end
    end
  end
end
