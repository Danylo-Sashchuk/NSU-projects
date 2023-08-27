n = 3
a = [1, 2]

b = a.flat_map { |i| [i] * n }
print b
puts
print a.flat_map { |i| [i] * n }

n.times { |i| puts i }

array = [1]
puts
puts array[0 - 2]

puts
s = "012345"
puts s[1...s.length - 1]