module Part
  class Number
    attr_reader :value, :x, :y

    def initialize(value, x, y)
      @value = value
      @x = x
      @y = y
    end

    def adjacent_to?(other_x, other_y)
      other_x >= x - 1 && other_x <= x + value.to_s.length && other_y >= y - 1 && other_y <= y + 1
    end
  end

  class Symbol
    attr_reader :value, :x, :y

    def initialize(value, x, y)
      @value = value
      @x = x
      @y = y
    end
  end
end

numbers = []
symbols = []

def scan_line(line, regex)
  # puts "Testing #{line} with #{regex}..."
  matches = []
  start = 0
  while true
    # puts "Testing #{line[start..-1]}..."
    match = line[start..-1].match(regex)
    break if match.nil?
    # puts "Found #{match[0]} at #{match.begin(0)}..."

    match_start = start + match.begin(0)
    matches << [match[0], match_start]
    start = match_start + match[0].length
    # puts "New start: #{start}"
  end
  matches
end

File.open(ARGV[0]).each_line.with_index do |line, y|
  # puts "y = #{y} - #{line}"
  n = scan_line(line, /([0-9]+)/)
  n.each { |number_str, x| numbers << Part::Number.new(number_str.to_i, x, y) }
  # puts n.to_s
  s = scan_line(line, /([^\d\s\.])/)
  s.each { |symbol, x| symbols << Part::Symbol.new(symbol, x, y) }
  # puts s.to_s
end

result = numbers.select { |n| symbols.any? { |s| n.adjacent_to?(s.x, s.y) } }.map(&:value).sum
puts result
