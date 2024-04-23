module Caly
  class Calendar < Base
    attr_reader :id, :name, :description, :location, :timezone, :raw

    def initialize(id: nil, name: nil, description: nil, location: nil, timezone: nil, raw: nil)
      @id = id
      @name = name
      @description = description
      @location = location
      @timezone = timezone
      @raw = raw
    end

    class << self
      def caly_provider_for(provider)
        Caly::Providers.const_get(Util.classify(provider)).const_get("Calendar")
      end

      def list(provider, token)
        caly_provider_for(provider).token = token
        caly_provider_for(provider).list
      end
    end
  end
end
