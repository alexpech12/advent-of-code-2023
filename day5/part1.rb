data = File.read(ARGV[0])

file_sections = data.split("\n\n")

puts file_sections.to_s

seeds = file_sections[0].split(' ')[1..-1].map(&:to_i)

maps = file_sections[1..-1].map do |section|
  lines = section.split("\n")
  key = lines[0].split(' ')[0]
  ranges = lines[1..-1].map do |line|
    drs, srs, len = line.split(' ').map(&:to_i)

    range = (srs..(srs+len-1))
    offset = drs - srs
    [range, offset]
  end
  [key, ranges]
end.to_h

# Get soil for seed
min = seeds.map { |seed|
  prev_result = seed
  result = nil
  maps.map do |key, ms|
    puts "Mapping #{key}"
    result = prev_result
    ms.each { |range, offset|
      puts "Testing #{prev_result} in #{range} with offset #{offset}"
      if range.include? prev_result
        puts "Found!"
        result = prev_result + offset
        break
      end
    }
    prev_result = result
    puts "Result: #{result}"
  end
  result
}.min

puts min