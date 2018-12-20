# cards in hand
class Hand
  attr_accessor :name, :card, :cards, :card_points

  def initialize(name)
    @name = name
    @cards = []
  end

  # sum points
  def count_points
    points = 0
    @cards.each do |card|
      points += 1 if card.ace? && points + 11 > 21
      points += card.points if card.ace? && points + 11 <= 21
      points += card.points unless card.ace?
    end
    points
  end

  # add card to hand
  def add_card(card)
    add_card_to_hand(card)
  end

  # clear hand
  def clear_cards
    @cards.clear
  end

  # add card
  def add_card_to_hand(card)
    @cards << card
    @card_points = count_points
  end
end
