# Caly - One API, any Calendar
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
account = Caly::Account.new(provider, token)

account.list_calendars #=> Array of Caly::Calendar instances
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
