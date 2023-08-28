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

# Problem 4
# Two Pointer Approach
def is_palindrome_iterative?(s)
  left, right = 0, s.length - 1
  while left < right do
    return false if s[left += 1] != s[right -= 1]
  end
  true
end

# Recursive Approach
def is_palindrome(s)
  return true if s.length <= 1
  return is_palindrome(s[1...s.length - 1]) if s[0] == s[s.length - 1]
  false
end

# Problem 5
def consecutive_digits(n)

end

# test functions
def problem1_tests
  array = [1, 2, 3]
  puts "Problem 1 - Array Duplication: "
  puts "Test 1: " + test_problem1?(4, array, [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]).to_s
  puts "Test 2: " + test_problem1?(1, array, [1, 2, 3]).to_s
  puts "Test 3: " + test_problem1?(0, array, []).to_s
end

def problem2_tests
  puts "-------------------\n\nProblem 2 - Fibonacci Array:"
  puts "Test 1: " + test_problem2?(1, [1]).to_s
  puts "Test 2: " + test_problem2?(2, [1, 1]).to_s
  puts "Test 3: " + test_problem2?(10, [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]).to_s
end

def problem3_tests
  puts "-------------------\n\nProblem 3 - Fibonacci Number:"
  puts "Test 1: " + test_problem3?(10, 55).to_s
  puts "Test 2: " + test_problem3?(100, 354224848179261915075).to_s
  puts "Test 3: " + test_problem3?(1, 1).to_s
  puts "Test 4: " + test_problem3?(2, 1).to_s
end

def problem4_tests
  puts "-------------------\n\nProblem 4 - Is a Palindrome:"
  puts "Test 1: " + test_problem4?("abba", true).to_s
  puts "Test 2: " + test_problem4?("a", true).to_s
  puts "Test 3: " + test_problem4?("peach", false).to_s
end

def problem5_tests
  puts "-------------------\n\nProblem 5 - Consecutive Digits:"
  puts "Test 1: " + test_problem5?(2, false).to_s
  puts "Test 2: " + test_problem5?(22, true).to_s
  puts "Test 3: " + test_problem5?(54332, true).to_s
  puts "Test 3: " + test_problem5?(123454321, false).to_s
end

def test_problem1?(n, array, expected)
  actual = duple(n, array)
  actual == expected
end

def test_problem2?(i, expected)
  actual = fib_array(i)
  actual == expected
end

def test_problem3?(i, expected)
  actual = fib(i)
  actual == expected
end

def test_problem4?(s, expected)
  actual = is_palindrome(s)
  actual == expected
end

def test_problem5?(n, expected)
  actual = consecutive_digits(n)
  actual == expected
end

# run tests
problem1_tests
problem2_tests
problem3_tests
problem4_tests