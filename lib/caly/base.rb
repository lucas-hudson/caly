module Caly
  class Base
    class << self
      private

      def caly_provider_for(provider)
        raise ArgumentError.new("Unknown provider") unless AVAILABLE_PROVIDERS.include?(provider.to_sym)
        Caly.const_get("#{Util.classify(provider)}::#{name.split("::").last}")
      end

      def method_missing(symbol, *args)
        provider_name, token, opts = args
        opts ||= {}

        raise ArgumentError.new("Unknown provider") unless AVAILABLE_PROVIDERS.include?(provider_name.to_sym)
        raise ArgumentError.new("You must provide a token") unless token

        super unless (provider = caly_provider_for(provider_name)).respond_to?(symbol)

        Caly::Client.host = provider::HOST
        Caly::Client.token = token

        opts.is_a?(Hash) ? provider.public_send(symbol, **opts) : provider.public_send(symbol, opts)
      end
    end
  end
end
