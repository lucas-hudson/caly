module Caly
  class Error
    attr_reader :message, :code

    def initialize(message:, code:)
      @message = message
      @code = code
    end
  end
end
