require "json"
require "./version"

module Config
  class Hash
    class Val
      getter :value

      def initialize(@value)
      end
    end

    #alias Value = Val | Array(Value) | ::Hash(String, Value)
    
    def initialize()
      @_index = {} of String => Val
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
        value = (value as Val).value
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
      index = {} of String => Val
      data.keys.each do |key|
        value = data[key]

        # clone value
        new_value = self._clone_value(value)

        # create the key in index
        index_key = (root.size > 0 ? "#{root}." : "") + (key as String)
        index[index_key] = Val.new(new_value)

        # if value is an hash, index it
        if (value.is_a?(::Hash))
          index.merge!(self._build_index(value, index_key))
        end
      end

      return index as ::Hash
    end
  end
end
