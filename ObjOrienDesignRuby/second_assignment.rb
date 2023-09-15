# frozen_string_literal: true

# Class that represents DNA and its methods.
class DNA
  attr_reader :dna

  def initialize(dna)
    @dna = dna.to_s.upcase
  end

  def to_s
    dna.to_s
  end

  def length
    @dna.length
  end

  def hamming_distance(dna)
    correct_length?(dna)
  rescue ArgumentError => e
    print_exception(e)
  else
    dna = dna.to_s.upcase
    distance = 0
    @dna.chars.each_with_index do |char, index|
      distance += 1 if dna.to_s[index] != char
    end
    distance
  end

  def contains?(dna)
    @dna.include?(dna.to_s.upcase)
  end

  def positions(nucleotide)
    indexes = []
    @dna.chars.each_with_index do |char, index|
      indexes << index if char == nucleotide
    end
    indexes
  end

  def frequencies
    frequency = { 'A' => 0,
                  'C' => 0,
                  'G' => 0,
                  'T' => 0
    }
    @dna.each_char do |char|
      frequency[char] += 1
    end
    frequency
  end

  def ==(other)
    @dna.to_s == other.to_s
  end

  private

  def correct_length?(dna)
    raise ArgumentError, 'DNAs of different lengths' if dna.length != @dna.length
  end

  def print_exception(exception)
    puts "#{exception.class}: #{exception.message}"
    puts exception.backtrace
  end
end

# Class that implements calculating the expression in Reverse Polish Notation.
class SumIntegers

  def run
    puts "Hello!\nLet's do some calculations, shall we?"
    loop do
      input = user_input
      break if exit?(input)

      result = evaluate_expression(input)
      print_answer(result)
    end
  end

  def user_input(optional = {})
    return optional['expression'].split if optional.key?('expression') # hash attributes for convenient unit testing

    print "Write an expression in Reverse Polish Notation (or 'quit' to exit): "
    gets.chomp.split
  end

  def exit?(input)
    if input[0].to_s.downcase == 'quit'
      puts 'Bye!'
      true
    else
      false
    end
  end

  def evaluate_expression(input)
    operands = []
    input.each do |element|
      if number?(element)
        operands << element.to_i
      elsif operator?(element) && enough_operands?(operands)
        num1 = operands.pop
        num2 = operands.pop
        operands << apply_operator(num1, num2, element)
      else
        return nil
      end
    end
    operands
  end

  def number?(element)
    /^-?\d+(\.\d+)?$/.match?(element)
  end

  def operator?(element)
    %w[+ - * /].include?(element)
  end

  def enough_operands?(operands)
    operands.size > 1
  end

  def apply_operator(int1, int2, operator)
    operators = {
      '+' => int1 + int2,
      '-' => int1 - int2,
      '*' => int1 * int2,
      '/' => int1 / int2
    }
    operators[operator]
  end

  def print_answer(result)
    if result.nil? || result.size != 1
      puts 'Bad input!'
    else
      puts "The answer is: #{result[0]}"
    end
  end
end

#------------------------------
#         Test Classes
#------------------------------

# Static methods for convenient testing
class TestEngine
  RESET = "\e[0m"
  FAIL = "\e[31m"
  PASS = "\e[32m"

  # Template method for comparing expected and actual values
  def self.testing(expected)
    actual = yield
    if actual == expected
      print "#{PASS}Passed #{RESET}"
    else
      print "#{FAIL}Failed #{RESET}"
    end
  end

  # Method for searching and running test methods in a class
  def self.run_tests(clazz)
    puts("Run tests in #{clazz.class.name}:")
    methods = clazz.methods.select { |method_name| method_name.to_s.match(/^test\d*_?/) }
    methods = methods.sort_by { |method_name| method_name.to_s[/\d+/].to_i }
    methods.each do |method|
      print "#{method}: "
      clazz.send(method)
      print "\n"
    end
    puts("-------\n")
  end
end

# Tests for DNA
class DnaTest
  attr_accessor :dna

  def setup
    @dna = DNA.new('ATTGCC')
  end

  def test1
    setup
    puts "Test 1: #{TestEngine.testing(6) { @dna.length }}"
  end

  def test2
    setup
    puts "Test 2: #{TestEngine.testing('ATTGCC') { @dna.to_s }}"
  end

  def test3
    setup
    another_dna = DNA.new('TGC')
    puts "Test 3: #{TestEngine.testing(true) { @dna.contains?(another_dna) }}"
  end

  def test4
    setup
    another_dna = DNA.new('AT')
    puts "Test 4: #{TestEngine.testing(true) { @dna.contains?(another_dna) }}"
  end

  def test5
    setup
    another_dna = 'GG'
    puts "Test 5: #{TestEngine.testing(false) { @dna.contains?(another_dna) }}"
  end

  def test6
    setup
    puts "Test 6: #{TestEngine.testing([1, 2]) { @dna.positions('T') }}"
  end

  def test7
    setup
    dna2 = DNA.new('GTTGAC')
    puts "Test 7: #{TestEngine.testing(2) { @dna.hamming_distance(dna2) }}"
  end

  def test8
    setup
    puts "Test 8: #{TestEngine.testing(0) { @dna.hamming_distance(@dna) }}"
  end

  def test9
    setup
    puts "Test 9: #{TestEngine.testing(nil) do
      @dna.hamming_distance(DNA.new('AT'))
    end}"
  end

  def test10
    setup
    expected = { 'A' => 1, 'T' => 2, 'G' => 1, 'C' => 2 }
    puts "Test 10: #{TestEngine.testing(expected) { @dna.frequencies }}"
  end

  def test11
    setup
    dna2 = DNA.new(@dna)
    puts "Test 11: #{TestEngine.testing(true) { @dna.to_s == dna2.to_s }}"
  end

  def test12
    setup
    dna2 = DNA.new(dna)
    puts "Test 12: #{TestEngine.testing(true) { @dna == dna2 }}"
  end

  def test13
    setup
    sample = 'CA'
    puts "Test 13: #{TestEngine.testing(false) { @dna.contains?(sample) }}"
  end

  def test14
    setup
    @dna = DNA.new('AATTCC')
    expected = { 'A' => 2, 'T' => 2, 'G' => 0, 'C' => 2 }
    puts "Test 14: #{TestEngine.testing(expected) { @dna.frequencies }}"
  end
end

# Tests for RPN
class RpnTest
  attr_accessor :calculator

  def setup
    @calculator = SumIntegers.new
  end

  def test_user_input1
    setup
    expected = %w[10 20 /]
    TestEngine.testing(expected) { @calculator.user_input({ 'expression' => '10 20 /' }) }
  end

  def test_user_input2
    setup

  end
end

TestEngine.run_tests(DnaTest.new)
# TestEngine.run_tests(RpnTest.new)
