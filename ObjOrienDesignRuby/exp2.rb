# Card = Struct.new(:suit, :val) do
#   def to_s
#     "#{val} of #{suit}s"
#   end
# end
# a = Card.new 'Diamond', 7 do
#   def to_s
#     "#{val} of #{suit}s"
#   end
# end
# print a.to_s
# b = Card.new 'Heart', 2
#
# puts "\n" + b.to_s

# class B
# end
#
# a = B.new
# puts a.class.superclass.superclass

class HelloWorld
  def talk
    puts 'hello world'
  end
end

hello = HelloWorld.new
hello.talk

class HelloYou
  def talk(name)
    puts "Goodbye #{name}"
  end
end

hello2 = HelloYou.new
hello2.talk('Ralph')
hello2.talk('Ralph') # Goodbye Ralph

# redefine HelloYou#talk method
class HelloYou
  def talk(*name)
    print "Hello again "
    puts name.empty? ? "Huh??" : name[0]
  end
end

hello2.talk('Mike') # Hello again Mike
hello.talk

# test_cases = [
#   { :name => "Test 1", :expected => 6, :block => -> { dna.length } }
# ]
#
# test_cases.each do |x|
#   dna = "asd"
#   x[:block].call
# end

class TestEngine
  def self.testing(expected)
    actual = yield
    if actual == expected
      "#{PASS}Passed #{RESET}"
    else
      "#{FAIL}Failed #{RESET}"
    end
  end

  def self.param_test(array)
    array.each do |test|
      method = test[0]
      parameters = test[1...-1]
      expected = test[-1]
      TestEngine.testing(expected) { method.call(parameters, 2) }
    end
  end
end

int1, int2 = 10, 0