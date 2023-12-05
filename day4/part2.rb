class Card
  attr_reader :score, :additional_cards

  def initialize(score, index, additional_cards)
    @score = score
    @index = index
    @additional_cards = additional_cards
  end

  def count(cards)
    1 + additional_cards.map { |card| cards[card].count(cards) }.sum
  end
end

File.open(ARGV[0], 'r') do |f|
  result = 0
  card_counts = [1]
  scores = []
  cards = []
  f.readlines.each_with_index do |line, i|
    puts line
    winners, numbers = line.scan(/\: (.*)\|(.*)/).flatten
    winners = winners.split(' ').map(&:strip).map(&:to_i)
    numbers = numbers.split(' ').map(&:strip).map(&:to_i)

    correct = numbers.intersection(winners).length
    score = correct > 0 ? 2 ** (numbers.intersection(winners).length - 1) : 0

    cards << Card.new(score, i, ((i+1)..(i+correct)).to_a)
  end

  result = cards.map { |c| c.count(cards) }.sum

  puts result
end