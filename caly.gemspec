$:.push File.expand_path("../lib", __FILE__)

require "caly/version"

Gem::Specification.new do |s|
  s.name = "caly"
  s.version = Caly::VERSION
  s.summary = "Caly - One API, any Calendar"
  s.description = "Integrate easily with Google Calendar and Microsoft Outlook calendars."
  s.authors = ["Lucas Hudson"]
  s.email = "lucashudson.contact@gmail.com"
  s.homepage = "https://github.com/lucas-hudson/caly"
  s.license = "MIT"
  s.files = Dir[
    "lib/**/*",
    "MIT-LICENSE",
    "README.md"
  ]
end
