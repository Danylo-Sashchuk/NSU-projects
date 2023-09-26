# frozen_string_literal: true

require 'colorize'

class Wordly
  attr_reader :word

  def choose_word
    'abort'
  end

  # TODO: add comments
  def transform_word(word)
    hash = {}
    word.chars.each_with_index do |letter, index|
      hash[letter] ||= [] # Initialize an empty array if the letter is not yet in the hash
      hash[letter] << index
    end
    hash
  end

  def initialize
    raw_word = choose_word
    @word = transform_word(raw_word)
  end

  def check_input(input)
    @word.chars.each_with_index do |char, index|

    end
  end

  def play
    print "Guess the five-letter word:\n"
    loop do
      input = user_input
      result = check_input(input)
      print result
    end
  end
end

w = Wordly.new
print w.transform_word 'error'
