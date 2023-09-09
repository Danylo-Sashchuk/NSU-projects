class DNA
  attr_reader :dna

  def initialize(dna)
    @dna = dna.to_s
  end

  def to_s
    dna.to_s
  end

  def length
    @dna.length
  end

  def hamming_distance(dna)
    if dna.length != @dna.length
      raise ArgumentError, "dnas of different lengths"
    end

    distance = 0
    @dna.chars.each_with_index do |char, index|
      if dna.to_s[index] != char
        distance += 1
      end
    end
    distance
  end

  def contains?(dna)
    @dna.include?(dna.to_s)
  end

  def positions(i)
    indexes = []
    @dna.chars.each_with_index do |char, index|
      indexes << index if char == i
    end
    indexes
  end

  # TODO: ask if result hash should contain nucleotide that doesnt appear in dna such as { "A" => 0 }
  def frequencies
    frequency = {}
    @dna.each_char do |char|
      if frequency.key?(char)
        frequency[char] += 1
      else
        frequency[char] = 1
      end
    end
    frequency
  end

  def ==(other)
    @dna.to_s == other.to_s
  end
end

class SumInteger
  def run
    puts "Hello!\nLet sum some numbers, shall we?"
    items = []
    while items[0].to_s != "quit" do
      print "Enter the numbers: "
      input = gets.chomp
      items = input.split
      result = 0
      items.each do |i|
        begin
          number = Integer(i)
          result += number
        rescue ArgumentError
          result = "Bad input!"
          break
        end
      end
      puts result
    end
    puts "Bye!"
  end
end

class PolishNotation
  def run
    puts "Hello!\nLet's do some calculations, shall we?"
    elements = []
    while elements[0].to_s != "quit" do
      print "Write the expression in Reverse Polish Notation: "
      elements = gets.chomp.split
      operands = []
      elements.each do |i|
        begin
          number = Integer(i)
          result += number
        rescue ArgumentError
          result = "Bad input!"
          break
        end
      end
    end
  end
end

# Class with static methods for convenient testing
class TestEngine
  RESET = "\e[0m"
  FAIL = "\e[31m"
  PASS = "\e[32m"

  def self.testing(expected)
    actual = yield
    if actual == expected
      "#{PASS}Passed #{RESET}"
    else
      "#{FAIL}Failed #{RESET}"
    end
  end

  # Method for searching and running test methods in a class
  def self.run_tests(clazz)
    puts("Run tests in #{clazz.class.name.to_s}:")
    methods = clazz.methods.select { |method_name| method_name.to_s.match(/^test\d+/) }
    methods = methods.sort_by { |method_name| method_name.to_s[/\d+/].to_i }
    methods.each { |method| clazz.send(method) }
    puts("-------\n")
  end
end

class DNA_Test
  attr_accessor :dna

  def setup
    @dna = DNA.new("ATTGCC")
  end

  def test1
    setup
    puts "Test 1: " + TestEngine.testing(6) { @dna.length }
  end

  def test2
    setup
    puts "Test 2: " + TestEngine.testing("ATTGCC") { @dna.to_s }
  end

  def test3
    setup
    another_dna = DNA.new("TGC")
    puts "Test 3: " + TestEngine.testing(true) { @dna.contains?(another_dna) }
  end

  def test4
    setup
    another_dna = DNA.new("AT")
    puts "Test 4: " + TestEngine.testing(true) { @dna.contains?(another_dna) }
  end

  def test5
    setup
    another_dna = "GG"
    puts "Test 5: " + TestEngine.testing(false) { @dna.contains?(another_dna) }
  end

  def test6
    setup
    puts "Test 6: " + TestEngine.testing([1, 2]) { @dna.positions("T") }
  end

  def test7
    setup
    dna2 = DNA.new("GTTGAC")
    puts "Test 7: " + TestEngine.testing(2) { @dna.hamming_distance(dna2) }
  end

  def test8
    setup
    puts "Test 8: " + TestEngine.testing(0) { @dna.hamming_distance(@dna) }
  end

  def test9
    setup
    puts "Test 9: " + TestEngine.testing(nil) {
      begin
        @dna.hamming_distance(DNA.new('AT'))
      rescue ArgumentError => e
        puts "#{e.class}: #{e.message}"
        puts e.backtrace
      end
    }
  end

  def test10
    setup
    expected = { "A" => 1, "T" => 2, "G" => 1, "C" => 2 }
    puts "Test 10: " + TestEngine.testing(expected) { @dna.frequencies }
  end

  def test11
    setup
    dna2 = DNA.new(@dna)
    puts "Test 11: " + TestEngine.testing(true) { @dna.to_s == dna2.to_s }
  end

  def test12
    setup
    dna2 = DNA.new(dna)
    puts "Test 12: " + TestEngine.testing(true) { @dna == dna2 }
  end

  def test13
    setup
    sample = "CA"
    puts "Test 13: " + TestEngine.testing(false) { @dna.contains?(sample) }
  end
end

# TestEngine.run_tests(DNA_Test.new)
sum = SumInteger.new
print sum.run