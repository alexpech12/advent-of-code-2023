data = File.read(ARGV[0])

file_sections = data.split("\n\n")

seeds = file_sections[0].split(' ')[1..-1].each_slice(2).map { |start, length| (start.to_i..(start.to_i+length.to_i-1)) }

maps = file_sections[1..-1].map do |section|
  lines = section.split("\n")
  key = lines[0].split(' ')[0]
  ranges = lines[1..-1].map do |line|
    drs, srs, len = line.split(' ').map(&:to_i)
    range = (srs..(srs+len-1))
    offset = drs - srs
    [range, offset]
  end
  ranges
end


def get_location(maps, seed)
  # puts "Seed: #{seed}"
  # puts "Starting map at #{maps[0].to_s}"
  prev_result = seed
  result = nil
  maps.map do |ms|
    # puts "Mapping #{ms}"
    result = prev_result
    ms.each { |range, offset|
      # puts "Testing #{prev_result} in #{range} with offset #{offset}"
      if range.include? prev_result
        # puts "Found!"
        result = prev_result + offset
        break
      end
    }
    prev_result = result
    # puts "Result: #{result}"
  end
  # puts result
  result
end


locations_worth_testing = maps.map.with_index { |ranges, i|
  boundaries = ranges.map { |range, _| [range.begin, range.end] }.flatten.uniq.sort
  locations_at_boundaries = boundaries.map { |boundary| get_location(maps[i..-1], boundary) }
  locations_at_boundaries
}.flatten.sort.uniq
puts locations_worth_testing.to_s

reverse_maps =
  maps.reverse.map { |ranges| ranges.map { |range, offset|
    [((range.begin + offset)..(range.end + offset)), -offset]
  } }

puts "Testing reverse map..."
seed = 79
puts "Forwards, seed = #{seed}"
l = get_location(maps, seed)
puts "Backwards, location = #{l}"
s = get_location(reverse_maps, l)
puts "Got back seed = #{s}"

seeds_worth_testing = locations_worth_testing
  .map { |loc| get_location(reverse_maps, loc) }.sort.uniq
  .select { |seed| seeds.any? { |s| s.include? seed}}
# puts seeds_worth_testing.to_s


result = seeds_worth_testing.map { |seed| get_location(maps, seed) }.min
puts result
