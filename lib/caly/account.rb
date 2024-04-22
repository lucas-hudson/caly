module Caly
  class Account
    extend Forwardable

    attr_reader :provider, :token

    def_delegator :caly_provider, :list_calendars

    def initialize(provider, token)
      unless Caly::AVAILABLE_PROVIDERS.include?(provider.to_sym)
        raise ArgumentError.new("#{provider} isn't a supported provider.")
      end

      @provider = provider
      @token = token
    end

    def self.caly_provider_for(name)
      Caly::Providers.const_get(Util.classify(name))
    end

    def caly_provider
      @caly_provider ||= self.class.caly_provider_for(provider).new(token)
    end
  end
end
