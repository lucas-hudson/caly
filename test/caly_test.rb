require "test_helper"

describe Caly do
  it "must have a version number" do
    assert Caly::VERSION
  end

  it "must be a module" do
    assert_kind_of Module, Caly
  end
end
