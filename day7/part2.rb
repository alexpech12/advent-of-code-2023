class Hand
  attr_reader :cards, :bid, :card_enc

  def initialize(cards, bid)
    @cards = cards
    @card_enc = cards.split('').map { |c| 'J23456789TQKA'.index(c) }
    @bid = bid.to_i
  end

  def inspect
    "#{cards} #{bid} #{strength_str}"
  end

  def joker_count
    @joker_count ||= cards.count('J')
  end

  def strength
    counts = card_enc.group_by(&:itself).values.map(&:length).sort.reverse
    case counts
    when [5]
      7
    when [4,1]
      joker_count > 0 ? 7 : 6
    when [3,2]
      joker_count > 0 ? 7 : 5
    when [3,1,1]
      joker_count > 0 ? 6 : 4
    when [2,2,1]
      joker_count == 2 ? 6 : joker_count == 1 ? 5 : 3
    when [2,1,1,1]
      joker_count > 0 ? 4 : 2
    else
      1 + joker_count
    end
  end

  def strength_str
    case strength
    when 1
      'High Card'
    when 2
      'One Pair'
    when 3
      'Two Pair'
    when 4
      'Three of a Kind'
    when 5
      'Full House'
    when 6
      'Four of a Kind'
    when 7
      'Five of a Kind'
    end
  end

  def <=>(other)
    cmp = self.strength <=> other.strength
    return cmp unless cmp.zero?

    card_enc.each_with_index do |card, i|
      cmp = card <=> other.card_enc[i]
      return cmp unless cmp.zero?
    end
  end
end

hands = File.open(ARGV[0]).readlines.map { |line| Hand.new(*line.split(' ')) }

hands.sort.each { |h| puts h.inspect }

result = hands.sort.map.with_index { |hand, i| hand.bid * (i+1) }.sum
puts result