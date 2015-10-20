require "spec"
require "../src/*"

def from_yaml
  return Config::Yaml.new("./spec/spec.yml")
end
