require "simplecov"

SimpleCov.start { add_filter "/test/" }

require "shields_badge"
SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge

require "minitest/autorun"
require "webmock/minitest"
require "caly"
require "pry"

class Minitest::Spec
  def self.it_lists_calendars(provider, &block)
    it "must return an array of Calendar instances" do
      response = instance_exec(&block)

      assert response.is_a?(Array)
      assert response.sample.is_a?(Caly::Calendar)
      assert_equal "#{provider}_id", response.sample.id
      assert_equal "#{provider}_name", response.sample.name
    end
  end

  def self.it_creates_calendar(provider, &block)
    it "must return a Calendar instance" do
      response = instance_exec(&block)

      assert response.is_a?(Caly::Calendar)
      assert_equal "#{provider}_id", response.id
      assert_equal "#{provider}_name", response.name
    end
  end

  def self.it_returns_an_error(provider, &block)
    it "must return an Error instance" do
      json = json_response_for(provider, "error")
      stub_request(:any, /.*/).to_return_json(body: json, status: 401)

      response = instance_exec(&block)

      assert response.is_a?(Caly::Error)
      assert_equal response.type, "InvalidAuthenticationToken"
      assert_equal response.message, "Request had invalid authentication credentials."
      assert_equal response.code, "401"
    end
  end

  def json_response_for(provider, name)
    File.read("test/json/#{provider}/#{name}.json")
  end
end

class Minitest::Mock
  # Suppress warnings that are shown when delegating methods to a Minitest::Mock
  def respond_to_missing?(symbol, include_private = false)
    @expected_calls.key? symbol.to_sym
  end
end
