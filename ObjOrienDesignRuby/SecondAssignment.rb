class DNA
  def to_s

  end

  def length

  end

  def hamming_distance

  end

  def contains

  end

  def positions

  end

  def frequencies

  end
end

class Test
  attr_reader :reset, :pass, :fail

  def initialize
    @reset = "\e[0m"
    @fail = "\e[31m"
    @pass = "\e[32m"
  end

  def test(expected)
    actual = yield
    if actual == expected
      "#{:pass} Passed #{:reset}"
    else
      "#{:fail} Failed #{:reset}"
    end
  end
end
