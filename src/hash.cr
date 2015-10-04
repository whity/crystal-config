require "json"
require "./version"

module Config
    class Hash
        alias Type = ::JSON::Type

        json_mapping({
            _data: ::Hash,
            _index: ::Hash
        })

        def initialize(data : ::Hash)
            @_data = ::Hash(String, String).new
            @_index = ::Hash(String, Type).new

            self._data = self._clone(data) as ::Hash
            self._index = self._build_index(self._data)
        end

        def [](key : String)
            return self.get(key)
        end

        def get(key : String)
            value = self._index.fetch(key, nil)
            if (value != nil)
                return self._clone(value)
            end

            return value
        end

        def keys()
            return self._index.keys
        end

        def has_key?(key : String)
            return self._index.has_key?(key)
        end

        def merge(other : Hash)
            data = self.to_h
            data = data.merge(other._data)

            return Hash.new(data)
        end

        def merge!(other : Hash)
            merged = self.merge(other)
            self._data = merged._data
            self._index = merged._index

            return self
        end

        def to_h()
            return self._clone(@_data) as ::Hash
        end

        protected def _data()
            return @_data
        end

        protected def _index()
            return @_index
        end

        protected def _data=(value : ::Hash)
            @_data = value

            return value
        end

        protected def _index=(value : ::Hash)
            @_index = value

            return value
        end

        protected def _clone(data)
            json = data.to_json
            copy = JSON.parse(json)

            return copy
        end

        protected def _build_index(data : ::Hash, root="" : String)
            index = ::Hash(String, Type).new
            data.keys.each do |key|
                value = data[key]

                # create the key in index
                index_key = (root.size > 0 ? "#{ root }." : "") + key
                index[index_key] = value

                # if value is an hash, index it
                if (value.is_a?(::Hash))
                    index.merge!(self._build_index(value, index_key))
                end
            end

            return index as ::Hash
        end
    end
end
