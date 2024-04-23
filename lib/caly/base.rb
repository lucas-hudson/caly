module Caly
  class Base
    class << self
      attr_accessor :token

      METHODS = [:list, :get, :create].freeze

      private

      def headers
        {Authorization: "Bearer #{token}", "Content-Type": "application/json"}
      end

      def execute_request(method, path, body: nil)
        Caly::Client.new(self::URL, headers).execute_request(method, path, body: body)
      end

      def caly_provider_for(provider)
        Caly.const_get(Util.classify(provider)).const_get("Calendar")
      end

      def method_missing(symbol, *args)
        super unless METHODS.include?(symbol)

        provider, token, opts = *args
        opts ||= {}

        caly_provider_for(provider).token = token

        if opts.is_a?(String)
          caly_provider_for(provider).public_send(symbol, opts)
        else
          caly_provider_for(provider).public_send(symbol, **opts)
        end
      end
    end
  end
end
