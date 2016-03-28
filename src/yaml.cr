require "yaml"
require "./hash"

module Config
  class Yaml < Hash
    getter :filename

    def initialize(file : String)
      # check if config file exists and read it
      if (!File.exists?(file))
        raise ArgumentError.new("invalid file '#{file}'")
      end

      data = ::YAML.parse(File.open(file).gets_to_end)
      data = data ? data.as_h : (::Hash(String, ::YAML::Type).new)

      @filename = file

      return super(data)
    end

    def merge(other : Hash)
      merged = super(other)
      new_obj = Yaml.new(self.filename)
      new_obj._index = merged._index

      return new_obj
    end
  end
end
