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

def consecutive_digits(n)
  return false if n / 10 == 0
  result = []
  while n != 0 do
    result << n % 10
    n /= 10
  end
  print result
end

def call1
  puts 'start of method'
  yield
  puts 'and again'
  yield
end

call1 { puts 'hello world' }

a = [9, 10, 15]
print b