rock_map = File.readlines(ARGV[0]).map(&:chomp)

# Roll rocks north
def roll_north(rock_map)
  (0..(rock_map.length-1)).each do |y|
    (0..(rock_map[0].length-1)).each do |x|
      c = rock_map[y][x]
      next unless c == 'O'

      cy = y
      while cy > 0 && rock_map[cy - 1][x] == '.'
        rock_map[cy - 1][x] = 'O'
        rock_map[cy][x] = '.'
        cy -= 1
      end
    end
  end
end

def roll_south(rock_map)
  (0..(rock_map.length-1)).to_a.reverse.each do |y|
    (0..(rock_map[0].length-1)).each do |x|
      c = rock_map[y][x]
      next unless c == 'O'

      cy = y
      while cy < rock_map.length - 1 && rock_map[cy + 1][x] == '.'
        rock_map[cy + 1][x] = 'O'
        rock_map[cy][x] = '.'
        cy += 1
      end
    end
  end
end

def roll_east(rock_map)
  (0..(rock_map[0].length-1)).to_a.reverse.each do |x|
    (0..(rock_map.length-1)).each do |y|
      c = rock_map[y][x]
      next unless c == 'O'

      cx = x
      while cx < rock_map.length - 1 && rock_map[y][cx + 1] == '.'
        rock_map[y][cx + 1] = 'O'
        rock_map[y][cx] = '.'
        cx += 1
      end
    end
  end
end

def roll_west(rock_map)
  (0..(rock_map[0].length-1)).each do |x|
    (0..(rock_map.length-1)).each do |y|
      c = rock_map[y][x]
      next unless c == 'O'

      cx = x
      while cx > 0 && rock_map[y][cx - 1] == '.'
        rock_map[y][cx - 1] = 'O'
        rock_map[y][cx] = '.'
        cx -= 1
      end
    end
  end
end

stable = false
previous_results = []
cycles = 0
while !stable
  roll_north(rock_map)

  roll_west(rock_map)

  roll_south(rock_map)

  roll_east(rock_map)

  cycles += 1

  load = rock_map.reverse.map.with_index { |row, i| row.count('O') * (i+1) }.sum

  puts "Load after #{cycles} cycles = #{load}"

  previous_results << load

  next if cycles < 10
  # Try and find a looping sequence
  (2..(previous_results.length/2)).each do |n|
    # Do we have a repeating pattern of n values?
    if previous_results[-n..-1] == previous_results[-(2*n)..-(n+1)]
      puts "Found repeating pattern of #{n} values"
      sequence = previous_results[-n..-1]
      puts ((cycles - n + 1)..cycles).to_a.to_s
      puts sequence.to_s

      # Extrapolate sequence to value at 1000000000
      sequence_index = 1_000_000_000 % n - (cycles - n) % n - 1
      puts "Result = #{sequence[sequence_index]} (#{sequence_index})"

      stable = true
      break
    end
  end

  break if cycles > 10000
end
