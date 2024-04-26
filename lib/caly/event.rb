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
                :organizer,
                :location,
                :use_default_reminder,
                :reminders,
                :transparent,
                :status,
                :created,
                :updated,
                :raw,

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
      creator: nil,
      organizer: nil,
      attendees: nil,
      location: nil,
      use_default_reminder: true,
      reminders: nil,
      transparent: nil,
      status: nil,
      created: nil,
      updated: nil,
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
      @creator = creator
      @organizer = organizer
      @location = location
      @use_default_reminder = use_default_reminder
      @reminders = reminders
      @transparent = transparent
      @status = status
      @raw = raw
      @created = created
      @updated = updated
    end
  end
end
