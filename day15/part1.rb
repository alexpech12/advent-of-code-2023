def hash(str)
  str.split('').map(&:ord).reduce(0) { |acc, c| ((acc + c) * 17) % 256 }
end

steps = File.read(ARGV[0]).gsub("\n","").split(",")
result = steps.map { |step| hash(step) }.sum
puts result
