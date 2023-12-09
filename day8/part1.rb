lines = File.readlines(ARGV[0]).map(&:chomp)
directions = lines[0]
nodes = lines[2..-1].map { |line|
  k, l, r = line.scan(/(...) = \((...), (...)\)/).flatten
  [k, [l, r]]
}.to_h
DIRECTION_MAP = { 'L' => 0, 'R' => 1 }
loc = 'AAA'
i = 0
step_count = 0
while loc != 'ZZZ'
  loc = nodes[loc][DIRECTION_MAP[directions[i]]]
  i = (i + 1) % directions.length
  step_count += 1
end
puts step_count