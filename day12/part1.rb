class String
  def indexes(regex)
    to_enum(:scan, regex).map { Regexp.last_match.offset(0)[0] }
  end

  def set_indexes!(indexes, value)
    indexes.each { |i| self[i] = value }
  end

  def matches_groupings(groupings, delim='.')
    split(delim).map(&:length).select(&:positive?) == groupings
  end
end

spring_map = File.readlines(ARGV[0]).map { |line|
  springs, groupings = line.chomp.split(' ')
  groupings = groupings.split(',').map(&:to_i)

  [springs, springs.indexes(/\?/), groupings]
}

result = spring_map.map { |springs, indexes, groupings|
  count = 0
  (0..(indexes.length)).each { |bits_to_flip|
    indexes.combination(bits_to_flip).each { |bits|
      resolved_springs = springs.gsub('?','.')
      resolved_springs.set_indexes!(bits, '#')
      # puts "Testing combination #{resolved_springs}"
      if resolved_springs.matches_groupings(groupings)
        # puts "Found solution"
        count += 1
      end
    }
  }
  puts "Combinations for #{springs}, #{groupings} = #{count}"
  count
}.sum
puts result