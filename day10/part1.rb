require 'set'

module Direction
  UP = 0
  RIGHT = 1
  DOWN = 2
  LEFT = 3
end

DIRECTION_MAP = {
  '|' => [Direction::UP, Direction::DOWN],
  '-' => [Direction::LEFT, Direction::RIGHT],
  'L' => [Direction::UP, Direction::RIGHT],
  '7' => [Direction::LEFT, Direction::DOWN],
  'J' => [Direction::UP, Direction::LEFT],
  'F' => [Direction::DOWN, Direction::RIGHT],
  '.' => [],
  'S' => []
}

class Joint
  attr_reader :x, :y, :directions, :value

  def initialize(x, y, value, directions)
    @x = x
    @y = y
    @directions = directions
    @value = value
  end

  def next_steps
    [
      directions.include?(Direction::LEFT) ? [x - 1, y] : nil,
      directions.include?(Direction::UP) ? [x, y - 1] : nil,
      directions.include?(Direction::RIGHT) ? [x + 1, y] : nil,
      directions.include?(Direction::DOWN) ? [x, y + 1] : nil
    ].compact
  end

  def inspect
    "<#{x},#{y}>:#{value}"
  end
end

pipe_map = File.readlines(ARGV[0]).map.with_index do |line, y|
  line.chomp.split('').map.with_index { |c, x| [[x,y], Joint.new(x, y, c, DIRECTION_MAP[c])] }
end.flatten(1).to_h

start = pipe_map.select { |k, v| v.value == 'S' }.values.first
puts start.to_s
step = start


last_step = step
step = ARGV[0] == 'test.txt' ? pipe_map[[last_step.x + 1, last_step.y]] : pipe_map[[last_step.x, last_step.y - 1]]

path = [step]
while step.value != 'S'
  # puts "Next steps: #{step.next_steps}"
  # puts "Next steps: #{step.next_steps.map { |x, y| pipe_map[[x,y]] }}"
  next_step = step.next_steps.map { |x, y| pipe_map[[x,y]] }.select { |joint| joint != last_step }.first
  last_step = step
  step = next_step
  path << step
  # puts "#{last_step}, #{step}, #{next_step}"
end

puts path.to_s
puts path.length
puts path.length / 2
