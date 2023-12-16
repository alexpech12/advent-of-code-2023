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
saved_states = []
cycles = 0
while cycles < 10 || stable.nil?
  # puts "Comparing:"
  # rock_map.each { |row| puts row }
  # puts "To saved:"
  # saved_state&.each { |row| puts row }
  stable = saved_states.index(rock_map)
  saved_states << rock_map.dup.map(&:dup)

  # rock_map.each { |row| puts row }
  # puts

  roll_north(rock_map)


  # rock_map.each { |row| puts row }
  # puts

  roll_west(rock_map)


  # rock_map.each { |row| puts row }
  # puts

  roll_south(rock_map)

  # rock_map.each { |row| puts row }
  # puts

  roll_east(rock_map)

  # rock_map.each { |row| puts row }
  # puts

  cycles += 1
  break if cycles > 10000
end
puts stable
puts cycles
result = rock_map.reverse.map.with_index { |row, i| row.count('O') * (i+1) }.sum
puts result
