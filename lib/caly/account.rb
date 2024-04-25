module Caly
  class Account
    def initialize(provider, token)
      @provider = provider
      @token = token
    end

    private

    def method_missing(symbol, ...)
      method, klass = symbol.to_s.split("_")
      klass = Util.classify(klass.gsub(/s$/, ""))

      Caly.const_get(klass).public_send(method, @provider, @token, ...)
    end

    def respond_to_missing?(symbol, *)
      ["_calendar"].any? { |name| symbol.to_s.include?(name) } || super
    end
  end
end
