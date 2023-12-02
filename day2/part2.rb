File.open(ARGV[0], 'r') do |f|
  count = 0
  f.readlines.each do |line|
    num, list = line.scan(/(\d+):(.*)/).flatten
    maximums = {
      'red' => 1,
      'green' => 1,
      'blue' => 1,
    }
    list.split(';').each { |game|
      puts game
      game.split(',').each { |set|
        puts set
        x, col = set.strip.scan(/(\d+) (\w+)/).flatten
        x = x.to_i
        maximums[col] = x if x > maximums[col]
      }
    }
    power = maximums.values.inject(:*)
    count += power
  end
  puts count
end