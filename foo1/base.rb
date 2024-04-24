module Foo
  class Base
    class << self
      METHODS = [:list, :get, :create].freeze

      def method_missing(symbol, *args)
        super unless METHODS.include?(symbol)

        provider_name, token, opts = *args

        raise ArgumentError.new("You must provide a provider name and a token") unless provider_name && token
        raise ArgumentError.new("Unknown provider") unless AVAILABLE_PROVIDERS.include?(provider_name.to_sym)

        provider = Foo::Providers.const_get(Foo::Util.classify(provider_name))::Calendar
        provider.token = token

        provider.public_send(symbol, **(opts || {}))
      end
    end
  end
end
