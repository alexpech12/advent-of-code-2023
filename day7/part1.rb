class Hand
  attr_reader :cards, :bid

  def initialize(cards, bid)
    @cards = cards.split('').map { |c| '23456789TJQKA'.index(c) }
    @bid = bid.to_i
  end

  def inspect
    "#{cards} #{bid} #{strength}"
  end

  def strength
    counts = cards.group_by(&:itself).values.map(&:length).sort.reverse
    case counts
    when [5]
      7
    when [4,1]
      6
    when [3,2]
      5
    when [3,1,1]
      4
    when [2,2,1]
      3
    when [2,1,1,1]
      2
    else
      1
    end
  end

  def <=>(other)
    cmp = self.strength <=> other.strength
    return cmp unless cmp.zero?

    cards.each_with_index do |card, i|
      cmp = card <=> other.cards[i]
      return cmp unless cmp.zero?
    end
  end
end

hands = File.open(ARGV[0]).readlines.map { |line| Hand.new(*line.split(' ')) }

hands.sort.each { |h| puts h.inspect }

result = hands.sort.map.with_index { |hand, i| hand.bid * (i+1) }.sum
puts result