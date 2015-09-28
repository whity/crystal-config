module Config
end

# h = {
#     "1" => "sss",
#     "2" => { "s": "ss" }
# }
#
# h2 = {
#     "4" => "1111",
# }
#
# c = Config::Hash.new(h)
# c2 = Config::Hash.new(h2)
#
# # merge new object
# puts "merge returning new object"
# puts c.to_h
# puts c.merge(c2).to_h
# puts c.to_h
#
# # merge object
# puts "merge to the object"
# puts c.to_h
# puts c.merge!(c2).to_h
# puts c.to_h
#
#
# # yaml
# c3 = Config.from_yaml("./spec/spec.yml")
#
# puts "yaml, merge returning new object"
# puts c3.to_h
# puts c3.merge(c).to_h
# puts c3.to_h
# puts c3.filename
#
#
# puts "yaml, merge to the object"
# puts c3.to_h
# puts c3.merge!(c).to_h
# puts c3.to_h
# puts c3.filename
#
# #puts c.to_json
#
# # def hash_array_2_yaml(data, level=0 : Int32)
# #     if (data.is_a?(::Hash))
# #         # hash
# #         output = Array(String).new
# #         data.keys.each do |key|
# #             value = data[key]
# #             if (value.is_a?(String))
# #                 output.push("#{ key }:#{ value }")
# #             end
# #         end
# #     end
# #
# #     # array
# #
# # end
