File.open(ARGV[0], 'r') do |f|
  count = 0
  f.readlines.each do |line|
    num, list = line.scan(/(\d+):(.*)/).flatten
    possible = list.split(';').all? { |game|
      game.split(',').all? { |set|
        puts set
        x, col = set.strip.scan(/(\d+) (\w+)/).flatten
        x = x.to_i
        case col
        when 'red'
          x <= 12
        when 'green'
          x <= 13
        when 'blue'
          x <= 14
        else
          raise "Unknown color: #{col}"
        end
      }
    }
    count += num.to_i if possible
  end
  puts count
end