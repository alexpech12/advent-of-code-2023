data = File.read(ARGV[0]).split("\n")
time = data[0].gsub(' ', '').scan(/\d+/).map(&:to_i)[0]
distance = data[1].gsub(' ', '').scan(/\d+/).map(&:to_i)[0]

l = (0..time).select { |wait_time|
  speed = wait_time
  d = (time - wait_time) * speed
  d > distance
}.length
puts "#{time}, #{distance}, #{l}"