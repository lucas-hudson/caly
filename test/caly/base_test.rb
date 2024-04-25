require "test_helper"

module Caly
  class Foo < Base; end

  module A
    class Foo < Caly::Foo
      HOST = "host".freeze

      def self.bar
        "bar"
      end

      def self.with_args(foobar)
        foobar
      end

      def self.with_kwargs(foo:)
        foo
      end
    end
  end

  describe Base do
    def setup
      @foo = Foo
    end

    describe "#delegation to provider class" do
      it "must call provider method" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          A::Foo.stub(:bar, "foobar") do
            assert_equal @foo.bar(:a, "token"), "foobar"
          end
        end
      end

      it "must forward named arguments" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          assert_equal @foo.with_args(:a, "token", "foobar"), "foobar"
        end
      end

      it "must forward key word arguments" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          assert_equal @foo.with_kwargs(:a, "token", foo: "foobar"), "foobar"
        end
      end

      it "must work with no arguments" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          assert_equal @foo.bar(:a, "token"), "bar"
        end
      end

      it "must raise an error if the provider is unknown" do
        @foo.bar(:unknown_provider, "token")
      rescue ArgumentError => e
        assert_equal e.message, "Unknown provider"
      end

      it "must raise an error if no token is provided" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          @foo.bar(:a)
        end
      rescue ArgumentError => e
        assert_equal e.message, "You must provide a token"
      end

      it "must raise an error if the method isn't handled by the provider" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          @foo.unknown_method(:a, "token")
        end
      rescue NoMethodError => e
        assert_equal e.message, "undefined method `unknown_method' for Caly::Foo:Class"
      end
    end

    describe "assignment to Client class" do
      it "must assign the host" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          A::Foo.stub(:bar, "foobar") do
            Client.host = nil
            @foo.bar(:a, "token")

            assert_equal Client.host, A::Foo::HOST
          end
        end
      end

      it "must assign the token" do
        Caly.stub_const(:AVAILABLE_PROVIDERS, [:a]) do
          A::Foo.stub(:bar, "foobar") do
            Client.token = nil
            @foo.bar(:a, "token")

            assert_equal Client.token, "token"
          end
        end
      end
    end
  end
end
