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
      if exit?(input)
        puts 'Bye!'
        break
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
  TestCase = Struct.new(:function, :expected)

  # Template method for comparing expected and actual values
  def self.testing(expected)
    actual = yield
    if actual == expected
      "#{PASS}Passed #{RESET}"
    else
      "#{FAIL}Failed #{RESET}"
    end
  end

  def self.test_with_one_parameter(test_case)

  end

  # Method for searching and running test methods in a class
  def self.run_tests(clazz)
    puts("Run tests in #{clazz.class.name}:")
    methods = clazz.methods.select { |method_name| method_name.to_s.match(/^test\d*_?/) }
    methods = sort_methods(methods)
    methods.each do |method|
      print "#{method}: #{clazz.send(method)}\n"
    end
    puts("-------\n")
  end

  def self.sort_methods(methods)
    methods.sort_by do |method_name|
      match_data = method_name.to_s.match(/^(\D+)(\d*)$/)
      name_part = match_data[1]
      number_part = match_data[2].to_i
      [name_part, number_part]
    end
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
    user_input_template([->(expression) { @calculator.user_input(expression) }])
  end

  def test_user_input1
    setup
    expected = %w[10 20 /]
    TestEngine.testing(expected) { @calculator.user_input({ 'expression' => '10 20 /' }) }
  end

  def test_user_input2
    setup
    expected = %w[]
    TestEngine.testing(expected) { @calculator.user_input({ 'expression' => '' }) }
  end

  def test_user_input3
    setup
    expected = %w[10 20 / 4 *]
    TestEngine.testing(expected) { @calculator.user_input({ 'expression' => '10 20 / 4 *' }) }
  end

  def test_exit1
    setup
    TestEngine.testing(false) { @calculator.exit?(%w[10 20 / 4]) }
  end

  def test_exit2
    setup
    TestEngine.testing(false) { @calculator.exit?(%w[]) }
  end

  def test_exit3
    setup
    TestEngine.testing(false) { @calculator.exit?(%w[10 20 / 4 quit]) }
  end

  def test_exit4
    setup
    TestEngine.testing(true) { @calculator.exit?(%w[quit]) }
  end

  def test_exit5
    setup
    TestEngine.testing(true) { @calculator.exit?(%w[quit 10 20 -]) }
  end

  def test_number1
    setup
    TestEngine.testing(true) { @calculator.number?('1') }
  end

  def test_number2
    setup
    TestEngine.testing(true) { @calculator.number?('101') }
  end

  def test_number3
    setup
    TestEngine.testing(true) { @calculator.number?('-9') }
  end

  def test_number4
    setup
    TestEngine.testing(true) { @calculator.number?('-0') }
  end

  def test_number5
    setup
    TestEngine.testing(true) { @calculator.number?('0') }
  end

  def test_number6
    setup
    TestEngine.testing(false) { @calculator.number?('-0a') }
  end

  def test_number7
    setup
    TestEngine.testing(false) { @calculator.number?('-q10') }
  end

  def test_number8
    setup
    TestEngine.testing(false) { @calculator.number?('1000O') }
  end

  def test_number9
    setup
    TestEngine.testing(false) { @calculator.number?('1000O  10') }
  end

  def test_operator1
    setup
    TestEngine.testing(false) { @calculator.operator?('1000O  10') }
  end

  def test_operator2
    setup
    TestEngine.testing(true) { @calculator.operator?('-') }
  end

  def test_operator3
    setup
    TestEngine.testing(true) { @calculator.operator?('+') }
  end

  def test_operator4
    setup
    TestEngine.testing(true) { @calculator.operator?('/') }
  end

  def test_operator5
    setup
    TestEngine.testing(true) { @calculator.operator?('*') }
  end

  def test_operator6
    setup
    TestEngine.testing(false) { @calculator.operator?('+-') }
  end

  def test_operator7
    setup
    TestEngine.testing(false) { @calculator.operator?(%w[+-/*]) }
  end

  def test_operator8
    setup
    TestEngine.testing(false) { @calculator.operator?(%w[+ - / *]) }
  end

  def test_enough_operands1
    setup
    TestEngine.testing(true) { @calculator.enough_operands?([10, 10]) }
  end

  def test_enough_operands2
    setup
    TestEngine.testing(false) { @calculator.enough_operands?([10]) }
  end

  def test_enough_operands3
    setup
    TestEngine.testing(true) { @calculator.enough_operands?([10, 10, 10]) }
  end

  def test_enough_operands4
    setup
    TestEngine.testing(false) { @calculator.enough_operands?([]) }
  end

  def test_apply_operator1
    setup
    TestEngine.testing(-1) { @calculator.apply_operator(1, 2, '-') }
  end

  def test_apply_operator2
    setup
    TestEngine.testing(3) { @calculator.apply_operator(1, 2, '+') }
  end

  def test_apply_operator3
    setup
    TestEngine.testing(20) { @calculator.apply_operator(10, 2, '*') }
  end

  def test_apply_operator4
    setup
    TestEngine.testing(10) { @calculator.apply_operator(100, 10, '/') }
  end

  def test_apply_operator5
    setup
    TestEngine.testing(nil) { @calculator.apply_operator(1, 2, '=') }
  end

  def test_apply_operator6
    setup
    TestEngine.testing(nil) { @calculator.apply_operator(1, 2, 10) }
  end

  def test_print_answer1
    setup
    TestEngine.testing('Bad input!') { @calculator.answer([10, 10]) }
  end

  def test_print_answer2
    setup
    TestEngine.testing('Bad input!') { @calculator.answer(nil) }
  end

  def test_print_answer3
    setup
    TestEngine.testing('The answer is: 10') { @calculator.answer([10]) }
  end

  def test_evaluate_expression1
    setup
    TestEngine.testing([3]) { @calculator.evaluate_expression(%w[1 2 +]) }
  end

  def test_evaluate_expression2
    setup
    TestEngine.testing([30]) { @calculator.evaluate_expression(%w[1 2 + 10 *]) }
  end

  def test_evaluate_expression3
    setup
    TestEngine.testing(nil) { @calculator.evaluate_expression(%w[1 2 + 10 * -]) }
  end

  def test_evaluate_expression4
    setup
    TestEngine.testing([2]) { @calculator.evaluate_expression(%w[1 2 + 10 * 60 /]) }
  end

  def test_evaluate_expression5
    setup
    TestEngine.testing(nil) { @calculator.evaluate_expression(%w[1 2 + qwerty 10 * 60 /]) }
  end
end

TestEngine.run_tests(DnaTest.new)
TestEngine.run_tests(RpnTest.new)

# TODO: Parameterized Tests!!
