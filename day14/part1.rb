rock_map = File.readlines(ARGV[0]).map(&:chomp)

# Roll rocks north
rock_map.each_with_index do |row, y|
  row.each_char.with_index do |c, x|
    next unless c == 'O'
    cy = y
    while cy > 0 && rock_map[cy - 1][x] == '.'
      rock_map[cy - 1][x] = 'O'
      rock_map[cy][x] = '.'
      cy -= 1
    end
  end
end

result = rock_map.reverse.map.with_index { |row, i| row.count('O') * (i+1) }.sum
puts result
