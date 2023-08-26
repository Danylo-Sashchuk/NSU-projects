# Problem 1
def duple(n, a)
  result = Array.new
  n.times do
    a.each { |i| result << i }
  end
  result
end

# test functions
def problem1_test1?
  n = 4
  a = [1, 2, 3]

  expected = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]
  actual = duple(n, a)
  expected == actual
end

def problem1_test2?
  n = 1
  a = [1, 2, 3]

  expected = [1, 2, 3]
  actual = duple(n, a)
  expected == actual
end

def problem2_test3?
  n = 0
  a = [1, 2, 3]

  expected = [1, 2, 3]
  actual = duple(n, a)
  expected == actual
end

# run tests
puts "Problem 1: "
puts "Test 1: " + problem1_test1?.to_s
puts "Test 2: " + problem2_test3?.to_s
puts "Test 3: " + problem2_test3?.to_s