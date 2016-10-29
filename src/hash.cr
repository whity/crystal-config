require "./version"

module Config
  class Hash
    alias Value = String | Array(Value) | ::Hash(String, Value)

    def initialize()
      @_index = {} of String => Value
    end

    def initialize(data : ::Hash)
      initialize()

      # build index
      self._index = self._build_index(data)
    end

    def [](key)
      return self.get(key)
    end

    def []=(key, value)
      return self.set(key, value)
    end

    def get(key : String)
      value = self._index.fetch(key, nil)
      if (value != nil)
        return self._clone_value(value)
      end

      return value
    end

    def set(key : String, value)
      data = {key => value}
      data_index = self._build_index(data)

      self._index.merge!(data_index)

      return value
    end

    def keys
      return self._index.keys
    end

    def has_key?(key : String)
      return self._index.has_key?(key)
    end

    def merge(other : Hash)
      new_cfg = Hash.new
      new_cfg._index = self._index.merge(other._index)

      return new_cfg
    end

    def merge!(other : Hash)
      merged = self.merge(other)
      self._index = merged._index

      return self
    end

    protected def _clone_value(value)
      return value.clone
    end

    protected def _index
      return @_index
    end

    protected def _index=(value : ::Hash)
      @_index = value

      return value
    end

    protected def _build_index(data : ::Hash, root : String = "")
      fixed_data = self._convert_data(data).as(::Hash)
      index = {} of String => Value
      fixed_data.keys.each do |key|
        value = fixed_data[key]

        # create the key in index
        index_key = (root.size > 0 ? "#{root}." : "") + key
        index[index_key] = value

        # if value is an hash, index it
        if (value.is_a?(::Hash))
          index.merge!(self._build_index(value, index_key))
        end
      end

      return index.as(::Hash)
    end

    protected def _convert_data(data)
      if (data.is_a?(::Hash))
        new_data = {} of String => Value
        data.keys.each do |key|
          new_data[key.as(String)] = self._convert_data(data[key])
        end

        return new_data
      end

      if (data.is_a?(::Array))
        new_data = [] of Value
        data.each do |item|
          new_data.push(self._convert_data(item))
        end

        return new_data
      end

      return sprintf("%s", data)
    end
  end
end
