# frozen_string_literal: true

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
    raise ArgumentError, 'dnas of different lengths' if dna.length != @dna.length

    distance = 0
    @dna.chars.each_with_index do |char, index|
      distance += 1 if dna.to_s[index] != char
    end
    distance
  end

  def contains?(dna)
    @dna.include?(dna.to_s)
  end

  def positions(nucleotide)
    indexes = []
    @dna.chars.each_with_index do |char, index|
      indexes << index if char == nucleotide
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

  def get_input
    print "Write the expression in Reverse Polish Notation (or 'quit' to exit): "
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

  def is_number?(element)
    /^-?\d+(\.\d+)?$/.match?(element)
  end

  def is_operator?(element)
    %w[+ - * /].include?(element)
  end

  def has_enough_operands?(operands)
    operands.size > 1
  end

  def evaluate_expression(input)
    operands = []
    input.each do |element|
      if is_number?(element)
        operands << element.to_s
      elsif is_operator?(element) && has_enough_operands?(operands)
        num1 = operands.pop.to_i
        num2 = operands.pop.to_i
        operands << apply_operator(num1, num2, element)
      else
        return nil
      end
    end
    operands
  end

  def apply_operator(int1, int2, operator)
    operators = {
      "+" => int1 + int2,
      "-" => int1 - int2,
      "*" => int1 * int2,
      "/" => int1 / int2
    }

    operators[operator]
  end

  def print_answer(result)
    if result == nil || result.size != 1
      puts "Bad input!"
    else
      puts "The answer is: #{result[0]}"
    end
  end

  def run
    puts "Hello!\nLet's do some calculations, shall we?"
    loop do
      input = get_input
      break if exit?(input)

      result = evaluate_expression(input)
      print_answer(result)
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
    puts("Run tests in #{clazz.class.name}:")
    methods = clazz.methods.select { |method_name| method_name.to_s.match(/^test\d+/) }
    methods = methods.sort_by { |method_name| method_name.to_s[/\d+/].to_i }
    methods.each { |method| clazz.send(method) }
    puts("-------\n")
  end
end

# Test class
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
    puts "Test 9: #{TestEngine.testing(nil)}" do
      @dna.hamming_distance(DNA.new('AT'))
    rescue ArgumentError => e
      puts "#{e.class}: #{e.message}"
      puts e.backtrace
    end
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
end

class CalculatorTest
  def test1
  end
end

# TestEngine.run_tests(DNA_Test.new)
sum = SumInteger.new
sum.run
