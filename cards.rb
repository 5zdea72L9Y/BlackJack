module Cards
  attr_reader :cards, :card_suit
  def initialize
    @cards = %w[1 2 3 4 5 6 7 8 9 10 J Q K A]
    @card_suit = %w[diamond spade club heart]
  end
end
