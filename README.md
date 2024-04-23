# Caly - One API, any Calendar
[![Gem Version](https://badge.fury.io/rb/caly.svg)](https://badge.fury.io/rb/caly)
[![Ruby Code Style](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)
[![Coverage](badge.svg)](https://github.com/Lucas-Hudson/caly)

Caly unifies endpoints and object data models across many calendar APIs, helping you instantly integrate your app with 
[Google Calendar](https://developers.google.com/calendar/api/guides/overview) and 
[Microsoft Outlook](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0) in one go.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "caly"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install caly
```

## Usage V1
```ruby
account = Caly::Account.new(provider, token)

# Calendars
account.list_calendars #=> Array of Caly::Calendar instances
account.get_calendar(id) #=> Caly::Calendar instance
account.create_calendar(name: "Calendar") #=> Caly::Calendar instance
account.update_calendar(id: id, name: "New name") #=> Caly::Calendar instance
account.delete_calendar(id) #=> true

# Events
account.list_events #=> Array of Caly::Event instances
account.get_event(id) #=> Caly::Event instance
account.create_event(name: "Event") #=> Caly::Event instance
account.update_event(id: id, name: "New name") #=> Caly::Event instance
account.delete_event(id) #=> true
```

## Usage V2
```ruby
account = Caly::Account.new(provider, token)

# Calendars
calendar = Caly::Calendar.new(account)
calendar.list #=> Array of Caly::Response::Calendar instances
calendar.get(id) #=> Caly::Response::Calendar instance
calendar.create(name: "Calendar") #=> Caly::Response::Calendar instance
calendar.update(id: id, name: "New name") #=> Caly::Response::Calendar instance
calendar.delete(id) #=> true

# Events
event = Caly::Event.new(account)
event.list(calendar_id) #=> Array of Caly::Response::Event instances
event.get(id) #=> Caly::Response::Event instance
event.create(calendar_id: id, name: "Event") #=> Caly::Response::Event instance
event.update(id: id, name: "New name") #=> Caly::Response::Event instance
event.delete(id) #=> true

# Examples

class User
  caly with: :caly_account # delegates caly methods to :caly_account
  
  def caly_account
    Caly::Account.new(provider, token)
  end
end

class Calendar
  def availabilites
    user.list_availabilites(external_id)
  end
end

class Event
  before_create :create_event_on_provider
  
  def create_event_on_provider
    event = user.create_event(start_at: start_at, end_at: end_at)
    self.external_id = event.id
  end
end

# Select calendar
calendar = user.list_calendars.first # => Lists calendars
user.calendars.create(provider: user.provider, external_id: calendar.id) # => Save select calendar locally

# View availabilities
availability = user.calendar.availabilites.first # => Select availability 
user.calendar.events.create(start_at: availability.start_at, end_at: availability.end_at) # => Create event
```

## Contributing
First of all, **thank you** for wanting to help and reading this!

If you have an issue you'd like to submit, please do so using the issue tracker in GitHub. Please be as detailed as you can.

If you'd like to open a PR please make sure the following things pass:

```ruby
rake test
standardrb
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
