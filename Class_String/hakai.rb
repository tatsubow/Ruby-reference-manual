# !がつくものは破壊的だが、逆は成り立たない
a = "string"
b = a
a.upcase!
p a # => "STRING"
p b # => "STRING"

a = "string"
b = a
a = a.upcase
p a # => "STRING"
p b # => "string"
