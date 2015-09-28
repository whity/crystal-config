require "json"

module Config
    class Hash
        alias Type = String | Array(Type) | ::Hash(String, Type)

        json_mapping({
            _data: ::Hash
        })

        def initialize(data : ::Hash)
            @_data = ::Hash(String, String).new

            self._data = self._clone(data)
        end

        def [](key : String)
            return self.get(key)
        end

        def get(key : String)
            value = self.to_h
            key.split('.').each do |item|
                value = value.fetch(item, nil)
                if (!value.is_a?(::Hash))
                    break
                end

                value = value as ::Hash
            end

            return value
        end

        def merge(other : Hash)
            data = self.to_h
            data = data.merge(other._data)

            return Hash.new(data)
        end

        def merge!(other : Hash)
            self._data = self.merge(other)._data

            return self
        end

        def to_h()
            return self._clone(@_data)
        end

        protected def _data()
            return @_data
        end

        protected def _data=(value : ::Hash)
            @_data = value

            return value
        end

        protected def _clone(data)
            json = data.to_json
            hash = JSON.parse(json) as ::Hash

            return hash
        end
    end
end
