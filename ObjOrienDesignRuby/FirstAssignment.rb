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
# Treating the input as a number
def consecutive_digits_(n)
  previous_digit = n % 10
  n /= 10
  while n != 0 do
    current_digit = n % 10
    return true if current_digit == previous_digit
    previous_digit = current_digit
    n /= 10
  end
  false
end

# Treating the input as a string
def consecutive_digits_s(n)
  s = n.to_s
  for i in 0...s.length - 1 do
    return true if s[i] == s[i + 1]
  end
  false
end

# Using method .each_cons
def consecutive_digits(n)
  s = n.to_s.chars
  s.each_cons(2) do |a, b|
    return true if a == b
  end
  false
end

# Problem 6
# O(n) Approach
def insert1(x, a)
  index = a.size
  for i in 0...a.size do
    if a[i] > x
      index = i
      break
    end
  end
  a.slice(0, index) + [x] + a.slice(index, a.size)
end

# O(LogN) Approach Using Binary Search
def insert(x, a)
  low, high = 0, a.size - 1
  while low <= high
    mid = (low + high) / 2
    if a[mid] < x
      low = mid + 1
    else
      high = mid - 1
    end
  end
  a.slice(0, low) + [x] + a.slice(low, a.size)
end

# Using Built-in Binary Search
def insert_bs(x, a)
  index = a.bsearch_index { |num| num > x } || a.size
  a.slice(0, index) + [x] + a.slice(index, a.size)
end

def insertion_sort(a)
  result = []
  a.each do |i|
    result = insert(i, result)
  end
  result
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
  puts "Test 4: " + test_problem5?(123454321, false).to_s
end

def problem6_tests
  puts "-------------------\n\nProblem 6 - Insert:"
  array = [2, 4, 5, 9, 12]
  puts "Test 1: " + test_problem6?(5, array, [2, 4, 5, 5, 9, 12]).to_s
  puts "Test 2: " + test_problem6?(10, array, [2, 4, 5, 9, 10, 12]).to_s
  puts "Test 3: " + test_problem6?(20, array, [2, 4, 5, 9, 12, 20]).to_s
  puts "Test 4: " + (array == [2, 4, 5, 9, 12]).to_s
end

def problem7_tests
  puts "-------------------\n\nProblem 7 - Insert Sort:"
  array = [30, 81, 43, 95, 24, 38, 64, 56, 74, 70, 33, 60]
  puts "Test 1: " + test_problem7?(array, [24, 30, 33, 38, 43, 56, 60, 64, 70, 74, 81, 95]).to_s
  puts "Test 2: " + (array == [30, 81, 43, 95, 24, 38, 64, 56, 74, 70, 33, 60]).to_s
  array = [10, -1, 5, 100, 8, 10]
  puts "Test 3: " + test_problem7?(array, [-1, 5, 8, 10, 10, 100]).to_s
  puts "Test 4: " + (array == [10, -1, 5, 100, 8, 10]).to_s
  array = [1]
  puts "Test 5: " + test_problem7?(array, [1]).to_s
  puts "Test 6: " + (array == [1]).to_s
  array = []
  puts "Test 7: " + test_problem7?(array, []).to_s
  puts "Test 8: " + (array == []).to_s
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

def test_problem6?(x, a, expected)
  actual = insert(x, a)
  actual == expected
end

def test_problem7?(a, expected)
  actual = insertion_sort(a)
  actual == expected
end

# run tests
problem1_tests
problem2_tests
problem3_tests
problem4_tests
problem5_tests
problem6_tests
problem7_tests