class Minitest::Spec
  def json_for(provider, name)
    File.read("test/json/#{provider}/#{name}.json")
  end

  def request_for(provider, name)
    config = {
      google_oauth2: {
        root: "https://www.googleapis.com/calendar/v3",
        list_calendars: {path: "/users/me/calendarList", body: json_for(provider, :list_calendars), code: 200},
        get_calendar: {path: "/calendars/", body: json_for(provider, :get_calendar), code: 200},
        create_calendar: {path: "/calendars", body: json_for(provider, :get_calendar), code: 200},
        update_calendar: {path: "/calendars/", body: json_for(provider, :get_calendar), code: 200},
        delete_calendar: {path: "/calendars/", body: nil, code: 204}
      },
      microsoft_graph: {
        root: "https://graph.microsoft.com/v1.0/me",
        list_calendars: {path: "/calendars", body: json_for(provider, :list_calendars), code: 200},
        get_calendar: {path: "/calendars/", body: json_for(provider, :get_calendar), code: 200},
        create_calendar: {path: "/calendars", body: json_for(provider, :get_calendar), code: 201},
        update_calendar: {path: "/calendars/", body: json_for(provider, :get_calendar), code: 200},
        delete_calendar: {path: "/calendars/", body: nil, code: 204}
      }
    }

    {
      path: [config.dig(provider, :root), config.dig(provider, name, :path)].join,
      body: config.dig(provider, name, :body),
      code: config.dig(provider, name, :code)
    }
  end
end
