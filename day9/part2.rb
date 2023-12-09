histories = File.readlines(ARGV[0]).map do |line|
  line.chomp.split(' ').map(&:to_i)
end

result = histories.map do |history|
  differences = [history]
  until differences[-1]&.all?(0)
    differences << differences[-1].each_cons(2).map { |a, b| b - a }
  end
  differences.map!(&:reverse)
  (differences.length-1).downto(1).each do |i|
    differences[i-1] << differences[i-1][-1] - differences[i][-1]
  end
  differences[0][-1]
end.sum

puts result