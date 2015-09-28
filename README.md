# config

A simple module to read configuration files, currently has support to:
  - yaml

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  config:
    github: whity/crystal-config
```


## Usage


```crystal
require "config/yaml" # for yaml files
require "config/hash" # for hash objects


# instanciate object
config = Config::Hash.new({
  "key1": "1234",
  "key2": "123344",
  "hash": {
    "key1": "56",
    "key2": "ehehe"
  }
})

# for yaml, Config::Yaml.new("filename")

# get key
puts config.get("key1")
puts config["hash.key2"]

# merge with another object
config2 = Config::Hash.new({
  "key3": "ohohohooh"
})
config = config.merge(config2) # or config.merge!(config2)

```


## Contributing

1. Fork it ( https://github.com/whity/crystal-config/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- whity(https://github.com/whity) André Brás - creator, maintainer
