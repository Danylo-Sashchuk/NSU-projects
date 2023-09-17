# frozen_string_literal: true

# Class that represents DNA and its methods
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
    frequency = {
      'A' => 0,
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
      if exit?(input)
        puts 'Bye!'
        return
      end

      result = evaluate_expression(input)
      puts answer(result)
    end
  end

  def user_input(expression = nil)
    if !expression.nil? # hash attributes for convenient unit testing
      expression.split
    else
      print "Write an expression in Reverse Polish Notation (or 'quit' to exit): "
      gets.chomp.split
    end
  end

  def exit?(input)
    input[0].to_s.downcase == 'quit'
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

  def answer(result)
    if result.nil? || result.size != 1
      'Bad input!'
    else
      "The answer is: #{result[0]}"
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
      "#{PASS}Passed #{RESET}"
    else
      "#{FAIL}Failed #{RESET}"
    end
  end

  # Method for searching and running test methods in a class
  def self.run_tests(clazz)
    puts("Run tests in #{clazz.class.name}:")
    methods = clazz.methods.select { |method_name| method_name.to_s.match(/^test\d*_?/) }
    methods = sort_methods(methods)
    methods.each do |method|
      print "#{method}: "
      print "#{clazz.send(method)}\n"
    end
    print "------------\n\n"
  end

  def self.sort_methods(methods)
    methods.sort_by do |method_name|
      match_data = method_name.to_s.match(/^(\D+)(\d*)$/)
      name_part = match_data[1]
      number_part = match_data[2].to_i
      [name_part, number_part]
    end
  end

  # Implementation of parameterized test.
  # test_cases is an array of arrays where each array represents one test case.
  # In every test_case array first element is always Expected value, while all others are parameters for the method.
  # test_cases = [[true, 2], [false, 3]]
  def self.param_test(method, test_cases)
    test_cases.each_with_index do |test_case, index|
      print("\n\tTest #{index + 1}: #{execute_method(method, test_case)}")
    end
    ''
  end

  def self.execute_method(method, test_case)
    expected = test_case[0]
    parameters = test_case[1..]
    case parameters.size
    when 1
      test_one_parameter(method, expected, parameters)
    when 2
      test_two_parameters(method, expected, parameters)
    when 3
      test_three_parameters(method, expected, parameters)
    else
      raise ArgumentError
    end
  end

  def self.test_one_parameter(method, expected, parameter)
    testing(expected) { method.call(parameter[0]) }
  end

  def self.test_two_parameters(method, expected, parameters)
    p1 = parameters[0]
    p2 = parameters[1]
    testing(expected) { method.call(p1, p2) }
  end

  def self.test_three_parameters(method, expected, parameters)
    p1 = parameters[0]
    p2 = parameters[1]
    p3 = parameters[2]
    testing(expected) { method.call(p1, p2, p3) }
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
    TestEngine.testing(6) { @dna.length }
  end

  def test2
    setup
    TestEngine.testing('ATTGCC') { @dna.to_s }
  end

  def test3
    setup
    another_dna = DNA.new('TGC')
    TestEngine.testing(true) { @dna.contains?(another_dna) }
  end

  def test4
    setup
    another_dna = DNA.new('AT')
    TestEngine.testing(true) { @dna.contains?(another_dna) }
  end

  def test5
    setup
    another_dna = 'GG'
    TestEngine.testing(false) { @dna.contains?(another_dna) }
  end

  def test6
    setup
    TestEngine.testing([1, 2]) { @dna.positions('T') }
  end

  def test7
    setup
    dna2 = DNA.new('GTTGAC')
    TestEngine.testing(2) { @dna.hamming_distance(dna2) }
  end

  def test8
    setup
    TestEngine.testing(0) { @dna.hamming_distance(@dna) }
  end

  def test9
    setup
    TestEngine.testing(nil) { @dna.hamming_distance(DNA.new('AT')) }
  end

  def test10
    setup
    expected = { 'A' => 1, 'T' => 2, 'G' => 1, 'C' => 2 }
    TestEngine.testing(expected) { @dna.frequencies }
  end

  def test11
    setup
    dna2 = DNA.new(@dna)
    TestEngine.testing(true) { @dna.to_s == dna2.to_s }
  end

  def test12
    setup
    dna2 = DNA.new(dna)
    TestEngine.testing(true) { @dna == dna2 }
  end

  def test13
    setup
    sample = 'CA'
    TestEngine.testing(false) { @dna.contains?(sample) }
  end

  def test14
    setup
    @dna = DNA.new('AATTCC')
    expected = { 'A' => 2, 'T' => 2, 'G' => 0, 'C' => 2 }
    TestEngine.testing(expected) { @dna.frequencies }
  end
end

# Tests for RPN
class RpnTest
  attr_accessor :calculator

  def setup
    @calculator = SumIntegers.new
  end

  def test_user_inputs
    setup
    TestEngine.param_test(
      ->(expression) { @calculator.user_input(expression) },
      [
        [%w[10 20 /], '10 20 /'],
        [%w[], ''],
        [%w[10 20 / 4 *], '10 20 / 4 *']
      ]
    )
  end

  def test_exits?
    setup
    TestEngine.param_test(
      ->(input) { @calculator.exit?(input) },
      [
        [false, %w[10 20 / 4]],
        [false, %w[]],
        [false, %w[10 20 / 4 quit]],
        [true, %w[quit]],
        [true, %w[quit 10 20 -]]
      ]
    )
  end

  def test_numbers?
    setup
    TestEngine.param_test(
      ->(input) { @calculator.number?(input) },
      [
        [true, '1'],
        [true, '101'],
        [true, '-9'],
        [true, '-0'],
        [true, '0'],
        [false, '-0a'],
        [false, '-q10'],
        [false, '1000O'],
        [false, '1000O  10']
      ]
    )
  end

  def test_operators?
    setup
    TestEngine.param_test(
      ->(input) { @calculator.operator?(input) },
      [
        [true, '-'],
        [true, '+'],
        [true, '/'],
        [true, '*'],
        [false, %w[+ -]],
        [false, %w[+ - / *]],
        [false, %w[+ - / *]]
      ]
    )
  end

  def test_enough_operands?
    setup
    TestEngine.param_test(
      ->(input) { @calculator.enough_operands?(input) },
      [
        [true, [10, 10]],
        [false, [10]],
        [true, [10, 10, 10]],
        [false, []]
      ]
    )
  end

  def test_apply_operators
    setup
    TestEngine.param_test(
      ->(int1, int2, operator) { @calculator.apply_operator(int1, int2, operator) },
      [
        [-1, 1, 2, '-'],
        [3, 1, 2, '+'],
        [20, 10, 2, '*'],
        [10, 100, 10, '/'],
        [nil, 1, 2, '='],
        [nil, 1, 2, 10]
      ]
    )
  end

  def test_answer
    setup
    TestEngine.param_test(
      ->(input) { @calculator.answer(input) },
      [
        ['Bad input!', [10, 10]],
        ['Bad input!', nil],
        ['The answer is: 10', [10]]
      ]
    )
  end

  def test_evaluate_expressions
    setup
    TestEngine.param_test(
      ->(input) { @calculator.evaluate_expression(input) },
      [
        [[3], %w[1 2 +]],
        [[30], %w[1 2 + 10 *]],
        [nil, %w[1 2 + 10 * -]],
        [[2], %w[1 2 + 10 * 60 /]],
        [nil, %w[1 2 + qwerty 10 * 60 /]]
      ]
    )
  end
end

TestEngine.run_tests(DnaTest.new)
TestEngine.run_tests(RpnTest.new)

r = SumIntegers.new
r.run
