# frozen_string_literal: true

require 'colorize'

class Printer
  def output(word)
    print("#{word}\n")
  end
end

class LinePrinter < Printer
  def output(word) end
end

class ColorizePrinter < Printer
  def output(word) end
end

class Wordly
  attr_reader :word, :letters, :printer, :color
  EXACT = '*'
  INCLUDED = '^'
  MISS = '-'

  def color=(value)
    if value == true
      @printer = ColorizePrinter.new
    elsif value == false
      @printer = LinePrinter.new
    else
      print("Wrong parameter! Values are limited by 'true' and 'false'. \n")
    end
  end

  def choose_word
    'ercar'
  end

  # TODO: add comments
  def count_letters(word)
    letter_count = {}
    word.each_char do |letter|
      letter = letter.downcase
      letter_count[letter] ||= 0
      letter_count[letter] += 1
    end
    letter_count
  end

  def initialize
    @word = choose_word

    # count letters to handle cases where the target word contains multiple identical letters
    @letters = count_letters(@word)
  end

  def check_word1(guess)
    output = Array.new(5)
    target_letters = @letters.dup
    unmatched_indexes = []

    # first pass - check the letters that match exactly
    guess.chars.each_with_index do |letter, index|
      if letter == @word[index]
        output[index] = 'E'
        target_letters[letter] -= 1
      else
        unmatched_indexes << index
      end
    end

    # then traverse through unmatched indexes for including/miss
    unmatched_indexes.each do |index|
      if target_letters.key?(guess[index]) && (target_letters[guess[index]]).positive?
        output[index] = 'I'
        target_letters[guess[index]] -= 1
      else
        output[index] = 'M'
      end
    end
    output
  end

  def check_word(guess)
    output = []
    target_positions = []
    guess_positions = []

    # Initialize target_positions and guess_positions
    @word.chars.each_with_index { |letter, index| target_positions[letter] ||= [] << index }
    guess.chars.each_with_index { |letter, index| guess_positions[letter] ||= [] << index }

    guess.chars.each_with_index do |letter, index|
      if letter == @word[index]
        output << 'E'
      elsif target_positions[letter] && target_positions[letter].any? { |pos| !guess_positions[letter].nil? && guess_positions[letter].include?(pos) }
        output << 'I'
        guess_positions[letter].delete_at(guess_positions[letter].index(target_positions[letter].shift))
      else
        output << 'M'
      end
    end

    output
  end

  def user_input
    gets.chomp
  end

  def play
    print "Guess the five-letter word:\n"
    6.times do
      guess = user_input
      result = check_word(guess)
      @printer.output(result)
      break if correct?(result)
    end
  end
end

w = Wordly.new
print w.check_word('error')
puts
print w.check_word1('error')
# print w.check_word('qwert')

# ercar