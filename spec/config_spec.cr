require "./spec_helper"
require "yaml"

describe "Config" do
  it "read yaml" do
    from_yaml.should(be_a(Config::Yaml))
  end

  it "get key 'hello' " do
    from_yaml.get("hello").should(eq("olá"))
  end

  it "get ['hello']" do
    from_yaml["hello"].should(eq("olá"))
  end

  it "merge" do
    to_merge = Config::Hash.new({"merged" => {"12" => "134", "11" => "1222", "int" => Int32}})
    c = from_yaml

    all_keys = to_merge.keys + c.keys
    all_keys.sort!

    c = c.merge(to_merge)
    c.keys.sort.should(eq(all_keys))
  end

  it "has_key" do
    c = from_yaml
    c.has_key?("xpto").should(eq(false))
  end
end
