module Caly
  class Calendar < Base
    METHODS = [:list, :get, :create]

    attr_reader :id, :name, :description, :location, :timezone, :raw

    def initialize(id: nil, name: nil, description: nil, location: nil, timezone: nil, raw: nil)
      @id = id
      @name = name
      @description = description
      @location = location
      @timezone = timezone
      @raw = raw
    end
  end
end
