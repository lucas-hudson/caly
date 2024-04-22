module Caly
  class Error
    attr_reader :message, :code, :type

    def initialize(type:, message:, code:)
      @type = type
      @message = message
      @code = code
    end
  end
end
