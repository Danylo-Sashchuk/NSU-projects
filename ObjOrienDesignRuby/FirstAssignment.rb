# Problem 1
def duple(n, a)
  result = Array.new
  a.each { |i| n.times { result << i } }
  result
end

# Using Array.flat_map method
def duple1(n, a)
  a.flat_map { |i| [i] * n }
end

# Problem 2
def fib_array(n)
  return [1] if n == 1
  fibonacci_array = [1, 1]
  (2...n).each do |i|
    fibonacci_array << fibonacci_array[i - 2] + fibonacci_array[i - 1]
  end
  fibonacci_array
end

# Problem 3
def fib(n)
  first = 1
  second = 1
  (2...n).each do
    third = first + second
    first = second
    second = third
  end
  second
end

# test functions
def problem1_tests
  array = [1, 2, 3]
  puts "Problem 1 - Array Duplication: "
  puts "Test 1: " + problem1_test_is_passed?(4, array, [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]).to_s
  puts "Test 2: " + problem1_test_is_passed?(1, array, [1, 2, 3]).to_s
  puts "Test 3: " + problem1_test_is_passed?(0, array, []).to_s
end

def problem2_tests
  puts "-------------------\n\nProblem 2 - Fibonacci Array:"
  puts "Test 1: " + problem2_test_is_passed?(1, [1]).to_s
  puts "Test 2: " + problem2_test_is_passed?(2, [1, 1]).to_s
  puts "Test 3: " + problem2_test_is_passed?(10, [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]).to_s
end

def problem3_tests
  puts "-------------------\n\nProblem 3 - Fibonacci Number:"
  puts "Test 1: " + problem3_test_is_passed?(10, 55).to_s
  puts "Test 2: " + problem3_test_is_passed?(100, 354224848179261915075).to_s
  puts "Test 3: " + problem3_test_is_passed?(1, 1).to_s
  puts "Test 4: " + problem3_test_is_passed?(2, 1).to_s
end

def problem1_test_is_passed?(n, array, expected)
  actual = duple(n, array)
  actual == expected
end

def problem2_test_is_passed?(i, expected)
  actual = fib_array(i)
  actual == expected
end

def problem3_test_is_passed?(i, expected)
  actual = fib(i)
  actual == expected
end

# run tests
problem1_tests
problem2_tests
problem3_tests