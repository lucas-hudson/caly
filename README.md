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

## Usage
```ruby
# Call the classes directly
Caly::Calendar.list(provider, token) # => Array of Caly::Calendar
Caly::Calendar.get(provider, token, id) # => Caly::Calendar
Caly::Calendar.create(provider, token, name: name) # => Caly::Calendar

Caly::Event.list(provider, token, calendar_id) # => Array of Caly::Event
Caly::Event.get(provider, token, id) # => Caly::Event
Caly::Event.create(provider, token, starts_at: starts_at, ends_at: ends_at) # => Caly::Event

# Use the account wrapper
account = Caly::Account.new(provider, token)
account.list_calendars
account.get_calendar(id)
account.create_calendars(name: name)
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
