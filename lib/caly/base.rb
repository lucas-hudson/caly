module Caly
  class Base
    class << self
      private

      def caly_provider_for(provider)
        raise ArgumentError.new("Unknown provider") unless AVAILABLE_PROVIDERS.include?(provider.to_sym)
        Caly.const_get("#{Util.classify(provider)}::#{name.split("::").last}")
      end

      def method_missing(symbol, provider_name, token, ...)
        raise ArgumentError.new("You must provide a provider name and a token") unless provider_name && token

        super unless AVAILABLE_PROVIDERS.include?(provider_name.to_sym) &&
          (provider = caly_provider_for(provider_name)).respond_to?(symbol)

        Caly::Client.host = provider::HOST
        Caly::Client.token = token

        provider.public_send(symbol, ...)
      end
    end
  end
end
