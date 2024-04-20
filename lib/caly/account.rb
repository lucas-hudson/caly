module Caly
  class Account
    attr_reader :provider, :token

    def initialize(provider, token)
      unless Caly::AVAILABLE_PROVIDERS.include?(provider.to_sym)
        raise ArgumentError("#{provider} isn't a supported provider.")
      end

      @provider = provider
      @token = token
    end

    def self.caly_provider_for(name)
      "Caly::Providers::#{name.to_s.classify}".constantize
    end

    def caly_provider
      @caly_provider ||= self.class.caly_provider_for(provider).new(token)
    end

    def list_calendars
      caly_provider.list_calendars
    end
  end
end
