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