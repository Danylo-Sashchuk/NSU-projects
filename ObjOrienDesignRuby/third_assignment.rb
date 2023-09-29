# frozen_string_literal: true

require 'colorize'

class Printer
  def output(word)
    print("#{word}\n")
  end
end

class LinePrinter < Printer
  # def output(word) end
end

class ColorizePrinter < Printer
  # def output(word) end
end

class Wordly
  attr_reader :word, :letters, :printer, :color

  EXACT = '*'
  INCLUDED = '^'
  MISS = '-'

  def color=(value)
    if value == true
      @printer = ColorizePrinter.new
    elsif value.nil? || value == false
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

    @printer = LinePrinter.new
  end

  def check_word(guess)
    output = Array.new(5)
    target_letters = @letters.dup

    # first pass - check the letters that match exactly
    mark_exact_matches(guess, output, target_letters)

    # It's necessary to go through a separate loop to mark the correct letters.
    # Otherwise, the result will be wrong
    # if the target word or user word contains several identical letters.

    # then traverse again for including/miss
    mark_inclusions_and_misses(guess, output, target_letters)
    output
  end

  def user_input
    gets.chomp
  end

  def guessed?(result)
    result.each { |e| return false if e != 'E' }
    print("You are right! Well done!\n")
    true
  end

  def play
    print "Guess the five-letter word:\n"
    6.times do
      guess = user_input
      result = check_word(guess)
      @printer.output(result)
      return if guessed?(result)
    end
  end

  private

  def mark_inclusions_and_misses(guess, output, target_letters)
    guess.chars.each_with_index do |letter, index|
      if output[index].nil?
        if target_letters.key?(letter) && target_letters[letter].positive?
          output[index] = 'I'
          target_letters[letter] -= 1
        else
          output[index] = 'M'
        end
      end
    end
  end

  def mark_exact_matches(guess, output, target_letters)
    guess.chars.each_with_index do |letter, index|
      if letter == @word[index]
        output[index] = 'E'
        target_letters[letter] -= 1
      end
    end
  end
end

w = Wordly.new
w.play
# print w.check_word('error')
# puts
# # print w.check_word('qwert')

# ercar