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
    if dna.length != @dna.length
      raise ArgumentError, "dnas of different lengths"
    end

    distance = 0
    @dna.chars.each_with_index do |char, index|
      if dna.to_s[index] != char
        distance += 1
      end
    end
    distance
  end

  def contains?(dna)
    @dna.include?(dna.to_s)
  end

  def positions(i)
    indexes = []
    @dna.chars.each_with_index do |char, index|
      indexes << index if char == i
    end
    indexes
  end

  def frequencies

  end
end

class TestEngine
  RESET = "\e[0m"
  FAIL = "\e[31m"
  PASS = "\e[32m"

  def testing(expected)
    actual = yield
    if actual == expected
      "#{PASS}Passed #{RESET}"
    else
      "#{FAIL}Failed #{RESET}"
    end
  end

  def run_tests(clazz)
    methods = clazz.methods.select { |method_name| method_name.to_s.match(/^test\d+/) }.sort
    methods.each { |method| clazz.send(method) }
  end
end

class DNA_Test
  attr_reader :test_engine

  def initialize
    @test_engine = TestEngine.new
  end

  def run_tests
    puts "-------------------\nDNA Tests:"
    @test_engine.run_tests(self)
  end

  def test1
    dna = DNA.new("ATTGCC")
    puts "Test 1: " + @test_engine.testing(6) { dna.length }
  end

  def test2
    dna = DNA.new("ATTGCC")
    puts "Test 2: " + @test_engine.testing("ATTGCC") { dna.to_s }
  end

  def test3
    dna = DNA.new("ATTGCC")
    another_dna = DNA.new("TGC")
    puts "Test 3: " + @test_engine.testing(true) { dna.contains?(another_dna) }
  end

  def test4
    dna = DNA.new("ATTGCC")
    another_dna = DNA.new("AT")
    puts "Test 4: " + @test_engine.testing(true) { dna.contains?(another_dna) }
  end

  def test5
    dna = DNA.new("ATTGCC")
    another_dna = "GG"
    puts "Test 5: " + @test_engine.testing(false) { dna.contains?(another_dna) }
  end

  def test6
    dna = DNA.new("ATTGCC")
    puts "Test 6: " + @test_engine.testing([1, 2]) { dna.positions("T") }
  end

  def test7
    dna1 = DNA.new("ATTGCC")
    dna2 = DNA.new("GTTGAC")
    puts "Test 7: " + @test_engine.testing(2) { dna1.hamming_distance(dna2) }
  end

  def test8
    dna1 = DNA.new("ATTGCC")
    puts "Test 8: " + @test_engine.testing(0) { dna1.hamming_distance(dna1) }
  end

  def test9
    dna = DNA.new("ATTGCC")
    puts "Test 9: " + @test_engine.testing(nil) {
      begin
        dna.hamming_distance(DNA.new('AT'))
      rescue ArgumentError => e
        puts "#{e.class}: #{e.message}"
        puts e.backtrace
      end
    }
  end
end

dna_tests = DNA_Test.new
dna_tests.run_tests