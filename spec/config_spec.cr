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

  it "to hash" do
    to_cmp = YAML.load(File.open("./spec/spec.yml").gets_to_end)
    c = from_yaml

    c.to_h.should(eq(to_cmp))
  end

  it "merge" do
    to_merge = Config::Hash.new({"merged" => {"12" => "134", "11" => "1222"}})
    c = from_yaml

    hash = from_yaml.to_h
    hash.merge!(to_merge.to_h)

    c = c.merge(to_merge)

    c.to_h.should(eq(hash))
  end

  it "has_key" do
    c = from_yaml
    c.has_key?("xpto").should(eq(false))
  end
end
