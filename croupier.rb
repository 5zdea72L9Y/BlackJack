require_relative './hand'

# croupier class
class Croupier
  attr_reader :name
  attr_accessor :balance, :cards, :hand, :card_points

  def initialize(balance)
    @name = 'croupier'
    @hand = Hand.new(@name)
    @balance = balance
    @cards = @hand.cards
    @card_points = @hand.card_points
  end

  def move
    @card_points < 17 ? true : false
  end

  def add_card(card)
    @hand.add_card(card)
    @card_points = @hand.card_points
  end

end
