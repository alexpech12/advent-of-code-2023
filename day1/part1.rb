File.open(ARGV[0], 'r') do |f|
  lines = f.readlines
  sum = lines.map do |line|
    [line, line.reverse].map { |l| l.match(/([0-9])/)[0] }.join.to_i
  end.sum
  puts sum
end