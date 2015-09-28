require "spec"
require "../src/config/*"

def from_yaml()
    return Config::Yaml.new("./spec/spec.yml")
end
