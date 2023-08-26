def duple(n, a)
  result = Array.new
  n.times do
    a.each { |i| result << i }
  end
  result
end

print(duple(3, [12, 2, 3]))