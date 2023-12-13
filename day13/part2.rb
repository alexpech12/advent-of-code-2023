def test_reflection(array, row)
  il, ir = [row-1, row]
  smudges = 0

  until il == -1 || ir == array.length
    smudges += array[il].split('').zip(array[ir].split('')).count { |a, b| a != b }
    return false if smudges > 1
    il -= 1
    ir += 1
  end
  smudges == 1
end

reflections = File.read(ARGV[0]).split("\n\n").map { |reflection| reflection.split("\n") }

result = reflections.map do |reflection|
  index = (1..(reflection.length - 1)).find do |row|
    test_reflection(reflection, row)
  end

  next 100*index if index

  transposed_reflection = reflection.map { |row| row.split('') }.transpose.map { |row| row.join('') }

  index = (1..(transposed_reflection.length - 1)).find do |row|
    test_reflection(transposed_reflection, row)
  end
index
end.sum
puts result