require_relative './deck'

# cards in hand
class Hand
  attr_accessor :name, :card, :cards, :card_points

  def initialize(name)
    @name = name
    @deck = Deck.new
    @cards = @deck.cards
    @card_points = count_points
  end

  # sum points
  def count_points
    points = 0
    @cards.each do |card|
      points += 1 if card.ace? && points + 11 > 21
      points += card.points if card.ace? && points + 11 < 21
      points += card.points unless card.ace?
    end
    points
  end

  # add card to hand
  def add_card
    @deck.add_card_to_hand
    @cards = @deck.cards
    @card_points = count_points
  end

  # clear hand
  def clear_cards
    @cards = Deck.new.cards
    @card_points = count_points
  end
end
