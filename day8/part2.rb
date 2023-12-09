lines = File.readlines(ARGV[0]).map(&:chomp)
directions = lines[0]
nodes = lines[2..-1].map { |line|
  k, l, r = line.scan(/(...) = \((...), (...)\)/).flatten
  [k, [l, r]]
}.to_h
DIRECTION_MAP = { 'L' => 0, 'R' => 1 }

def gcd(a, b)
  r = a % b
  return b if r == 0
  gcd(b, r)
end

def lcm(a, b)
  (a * b) / gcd(a, b)
end

locs = nodes.select { |k,v| k =~ /..A/ }.keys
i = 0
step_counts =
  locs.map { |loc|
    step_count = 0
    while !(loc =~ /..Z/)
      loc = nodes[loc][DIRECTION_MAP[directions[i]]]
      i = (i + 1) % directions.length
      step_count += 1
    end
    step_count
  }
result = step_counts.reduce { |acc, x| lcm(acc, x) }
puts result