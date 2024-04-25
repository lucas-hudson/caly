class Minitest::Spec
  def json_for(provider, object, name)
    File.read("test/json/#{provider}/#{object}/#{name}.json")
  end

  def self.it_returns_an_error(provider, &block)
    it "must return an Error instance" do
      json = File.read("test/json/#{provider}/error.json")
      stub_request(:any, /.*/).to_return_json(body: json, status: 401)

      response = instance_exec(&block)

      assert response.is_a?(Caly::Error)
      assert_equal response.type, "InvalidAuthenticationToken"
      assert_equal response.message, "Request had invalid authentication credentials."
      assert_equal response.code, "401"
    end
  end
end
