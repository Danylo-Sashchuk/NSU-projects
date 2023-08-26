n = 3
a = [1, 2]

b = a.flat_map {|i| [i] * n}
print b
puts
print a.flat_map {|i| [i] * n}