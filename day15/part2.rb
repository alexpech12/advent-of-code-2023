def hash(str)
  str.split('').map(&:ord).reduce(0) { |acc, c| ((acc + c) * 17) % 256 }
end

steps = File.read(ARGV[0]).gsub("\n","").split(",").map { |step| step.scan(/([a-z]+)([-|=])(\d+)?/).flatten }

def print_boxes(boxes)
  boxes.each_with_index { |lenses, box_index|
    puts "Box #{box_index}: #{lenses&.map { |label, focal_length| "[#{label} #{focal_length}]" }&.join(', ')}"
  }
end

boxes = []
steps.each { |label, operation, focal_length|
  box_index = hash(label)
  # puts "#{label} (#{box_index}) #{operation} #{focal_length}"
  case operation
  when '='
    lenses = boxes[box_index] || []
    existing_lens_index = lenses.index { |lens| lens[0] == label }
    if existing_lens_index
      lenses[existing_lens_index][1] = focal_length
    else
      lenses << [label, focal_length]
    end
    boxes[box_index] = lenses
  when '-'
    boxes[box_index]&.delete_if { |lens| lens[0] == label }
  end
  # print_boxes(boxes)
  # puts
}

result = boxes.map.with_index { |lenses, box_index|
  next 0 unless lenses && !lenses.empty?

  puts "Calculating #{lenses}"

  lenses.map.with_index { |(label, focal_length), lens_index|
    (box_index + 1) * (lens_index + 1) * focal_length.to_i
  }.sum
}.sum
puts result