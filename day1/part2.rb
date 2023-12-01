NUMBER_MAP = {
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9,
  '1' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9
}
File.open(ARGV[0], 'r') do |f|
  lines = f.readlines
  sum = lines.map do |line|
    line = line.strip

    # `scan` letting me down...
    # matches = line.scan(/([1-9]|one|two|three|four|five|six|seven|eight|nine)/).flatten
    # r = [matches.first, matches.last].map { |m| NUMBER_MAP[m] }.join.to_i

    # Finding the 'real' last digit
    word_matcher = "one|two|three|four|five|six|seven|eight|nine"
    first_match = line.match(/([1-9]|#{word_matcher})/)[0]
    last_match = line.reverse.match(/([1-9]|#{word_matcher.reverse})/)[0].reverse
    [first_match, last_match].map { |m| NUMBER_MAP[m] }.join.to_i
  end.sum
  puts sum
end