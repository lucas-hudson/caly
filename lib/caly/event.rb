module Caly
  class Event < Base
    METHODS = [:list, :get, :create, :update, :delete]

    attr_reader :id,
                :calendar_id,
                :name,
                :description,
                :all_day,
                :starts_at,
                :start_time_zone,
                :ends_at,
                :end_time_zone,
                :attendees,
                :creator,
                :location,
                :created,
                :raw

    def initialize(
      id: nil,
      calendar_id: nil,
      name: nil,
      description: nil,
      all_day: false,
      starts_at: nil,
      start_time_zone: nil,
      ends_at: nil,
      end_time_zone: nil,
      attendees: nil,
      location: nil,
      created: nil,
      raw: nil
    )
      @id = id
      @calendar_id = calendar_id
      @name = name
      @description = description
      @all_day = all_day
      @starts_at = starts_at
      @start_time_zone = start_time_zone
      @ends_at = ends_at
      @end_time_zone = end_time_zone
      @attendees = attendees
      @location = location
      @raw = raw
      @created = created
    end
  end
end
