# Problem 1
# Naive approach
def duple(n, a)
  result = Array.new
  a.each { |i| n.times { result << i } }
  result
end

# Using Array.flat_map method
def duple1(n, a)
  a.flat_map {|i| [i] * n}
end


# test functions
def problem1_tests
  array = [1, 2, 3]
  puts "Problem 1: "
  puts "Test 1: " + problem1_test?(4, array, [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]).to_s
  puts "Test 2: " + problem1_test?(1, array, [1, 2, 3]).to_s
  puts "Test 3: " + problem1_test?(0, array, []).to_s
end

def problem1_test?(n, array, expected)
  actual = duple(n, array)
  actual == expected
end

# run tests
problem1_tests