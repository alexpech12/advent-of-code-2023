data = File.read(ARGV[0]).split("\n")
times = data[0].scan(/\d+/).map(&:to_i)
distances = data[1].scan(/\d+/).map(&:to_i)
races = times.zip distances

puts races.to_s

result = races.map { |time, distance|
  l = (0..time).select { |wait_time|
    speed = wait_time
    d = (time - wait_time) * speed
    puts "d from #{wait_time}, #{distance} = #{d}"
    d > distance
  }.length
  puts "#{time}, #{distance}, #{l}"
  l
}.inject(:*)
puts result