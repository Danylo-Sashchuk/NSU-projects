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
  attr_reader :word, :printer
  attr_accessor :color

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
    'abort'
  end

  # TODO: add comments
  def parse_word(word)
    hash = {}
    word.chars.each_with_index do |letter, index|
      hash[letter] ||= [] # Initialize an empty array if the letter is not yet in the hash
      hash[letter] << index
    end
    hash
  end

  def initialize
    target_word = choose_word
    @word = parse_word(target_word)
  end

  def check_word(input)
    @word.chars.each_with_index do |char, index|

    end
  end

  def play
    print "Guess the five-letter word:\n"
    6.times do
      word = user_input
      result = check_word(word)
      @printer.output(result)
      break if correct?(result)
    end
  end
end

w = Wordly.new
print w.parse_word 'error'
