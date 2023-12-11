# Idea for part 2
# Instead of actually expanding the array, just record the positions of each empty row/column
# The resulting position of a galaxy is it's x/y + the number of empty rows/columns before it

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

def find_empty_rows(starmap)
  starmap.map.with_index { |row, i| row.include?('#') ? nil : i }.compact
end

starmap = File.readlines(ARGV[0]).map(&:chomp)

empty_rows = find_empty_rows(starmap)
empty_columns = find_empty_rows(starmap.map { |row| row.split('') }.transpose.map { |row| row.join('') })
puts empty_rows.to_s
puts empty_columns.to_s

expansion_amount = ARGV[1].to_i || 2

# Find all galaxies
galaxies = []
starmap.each_with_index do |row, y|
  row.split('').each_with_index do |galaxy, x|
    next unless galaxy == '#'

    gx = x + empty_columns.select { |c| c < x }.length * (expansion_amount - 1)
    gy = y + empty_rows.select { |r| r < y }.length * (expansion_amount - 1)
    puts "Galaxy at (#{x}, #{y}) -> (#{gx}, #{gy})"
    galaxies << Galaxy.new(gx, gy)
  end
end

puts galaxies.to_s

result = galaxies.combination(2).map do |galaxy1, galaxy2|
  galaxy1.distance_to(galaxy2)
end.sum
puts result