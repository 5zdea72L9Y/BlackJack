require '../BlackJack/hand'

# croupier class
class Croupier
  attr_reader :name
  attr_accessor :balance, :cards, :hand, :card_points

  def initialize(balance=100)
    @name = 'croupier'
    @hand = Hand.new(@name)
    @balance = balance
    @cards = @hand.cards
    @card_points = @hand.card_points
  end

  def move
    @card_points < 17 ? add_card_croupier : skip
  end

  def skip
    false
  end

  def add_card_croupier
    @hand.add_card
    @card_points = @hand.card_points
    @cards.pop if @cards.count > 3
  end
end
