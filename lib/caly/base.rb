module Caly
  class Base
    attr_reader :provider, :token

    def self.caly_provider_for(provider)
      Caly::Providers.const_get(Util.classify(provider)).const_get("Calendar")
    end
  end
end
