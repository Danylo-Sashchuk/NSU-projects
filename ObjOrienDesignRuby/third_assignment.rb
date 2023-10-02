# frozen_string_literal: true

require 'colorize'
require_relative 'words'

# TODO: private methods

module Wordle
  class Printer
    def output(text)
      text.each { |char| print_symbol(char) }
      puts
    end

    def print_symbol(symbol)
      raise NoMethodError
    end
  end

  class LinePrinter < Printer
    def print_symbol(symbol)
      case symbol.result
      when 'E'
        print('*')
      when 'I'
        print('^')
      when 'M'
        print(' ')
      end
    end
  end

  class ColorizePrinter < Printer
    def print_symbol(symbol)
      print(case symbol.result
            when 'E'
              print(symbol.letter.colorize(:green))
            when 'I'
              print(symbol.letter.colorize(:yellow))
            when 'M'
              print(symbol.letter)
            end)
    end
  end

  class Game
    include Wordle
    attr_reader :word, :letters, :printer

    LetterFeedback = Struct.new(:result, :letter)

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
      Words.sample
      # 'ercar'
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
      output = Array.new(5) # output consists of result symbol (E, I, or M) and word char itself.

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

    def legitimate?(input)
      if input.length != 5
        print("Word must be exactly 5 letters long, write again.\n")
        return false
      end
      input.chars.each do |char|
        unless char.match?(/[A-Za-z]/)
          print("Word must have only letters, write again.\n")
          return false
        end
      end
      true
    end

    def user_input
      input = ''
      loop do
        input = gets.chomp
        break if legitimate?(input)
      end
      input
    end

    def guessed?(result)
      result.each { |e| return false if e.result != 'E' }
      print("You guessed it! Well done!\n")
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
      print "Oops, You have run out of attempts.\nThe target word was \"#{@word}\".\nGood luck next time!"
    end

    private

    def mark_inclusions_and_misses(guess, output, target_letters)
      guess.chars.each_with_index do |letter, index|
        next unless output[index].nil?

        if target_letters.key?(letter) && target_letters[letter].positive?
          output[index] = LetterFeedback.new('I', letter)
          target_letters[letter] -= 1
        else
          output[index] = LetterFeedback.new('M', letter)
        end
      end
    end

    def mark_exact_matches(guess, output, target_letters)
      guess.chars.each_with_index do |letter, index|
        next unless letter == @word[index]

        output[index] = LetterFeedback.new('E', letter)
        target_letters[letter] -= 1
      end
    end
  end
end

# w = Wordle::Game.new
# w.color = true
# w.play
