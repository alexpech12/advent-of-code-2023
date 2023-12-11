class Galaxy
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def inspect
    "Galaxy at (#{x}, #{y})"
  end

  def distance_to(galaxy)
    (x - galaxy.x).abs + (y - galaxy.y).abs
  end
end

def expand_starmap(starmap)
  empty_rows = starmap.map.with_index { |row, i| row.include?('#') ? nil : i }.compact
  puts empty_rows.to_s
  transposed_starmap = starmap.map { |row| row.split('') }.transpose.map { |row| row.join('') }
  puts transposed_starmap.to_s
  empty_columns = transposed_starmap.map.with_index { |row, i| row.include?('#') ? nil : i }.compact
  puts empty_columns.to_s
  expanded = []
  y = 0
  starmap.each do |row|
    empty_columns.sort.reverse.each { |y| row.insert(y, '.') }
    expanded << row
  end

  empty_rows.sort.reverse.each do |x|
    expanded.insert(x, (['.'] * expanded[0].length).join(''))
  end
  expanded
end

starmap = File.readlines(ARGV[0]).map(&:chomp)

def print_map(map)
  map.each { |row| puts row.to_s }
end
# print_map(starmap)

starmap = expand_starmap(starmap)
# print_map(starmap)

# Find all galaxies
galaxies = []
starmap.each_with_index do |row, y|
  row.split('').each_with_index do |galaxy, x|
    next unless galaxy == '#'

    galaxies << Galaxy.new(x, y)
  end
end

puts galaxies.to_s

result = galaxies.combination(2).map do |galaxy1, galaxy2|
  galaxy1.distance_to(galaxy2)
end.sum
puts result