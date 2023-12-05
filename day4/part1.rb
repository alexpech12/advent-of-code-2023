File.open(ARGV[0], 'r') do |f|
  result = 0
  f.readlines.each do |line|
    winners, numbers = line.scan(/\: (.*)\|(.*)/).flatten
    winners = winners.split(' ').map(&:strip).map(&:to_i)
    numbers = numbers.split(' ').map(&:strip).map(&:to_i)

    correct = numbers.intersection(winners).length
    result += correct > 0 ? 2 ** (numbers.intersection(winners).length - 1) : 0
  end
  puts result
end