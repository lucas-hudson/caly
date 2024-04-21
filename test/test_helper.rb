require "minitest/autorun"
require "webmock/minitest"
require "caly"
require "pry"

class Minitest::Spec
  def self.it_lists_calendars(provider, path, &block)
    it "must return an array of Calendar instances" do
      json = File.open("test/json/#{provider}/list_calendars.json").read
      stub_request(:get, "#{@url}/#{path}").to_return_json(body: json, status: 200)

      response = instance_exec(&block)

      assert response.is_a?(Array)
      assert response.sample.is_a?(Caly::Calendar)
      assert_equal "#{provider}_id", response.sample.id
      assert_equal "#{provider}_name", response.sample.name
    end
  end

  def self.it_returns_an_error(provider, path, &block)
    it "must return an Error instance" do
      json = File.open("test/json/#{provider}/list_calendars_error.json").read
      stub_request(:any, /.*/).to_return_json(body: json, status: 401)

      response = instance_exec(&block)

      assert response.is_a?(Caly::Error)
      assert_equal response.message, "Request had invalid authentication credentials."
      assert_equal response.code, "401"
    end
  end
end
