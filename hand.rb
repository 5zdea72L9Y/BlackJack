require '../BlackJack/card'
# card in hand
class Hand
  attr_accessor :name, :card, :cards, :card_points

  def initialize(name)
    @name = name
    @card = Card.new
    @cards = @card.cards
    @card_points = @card.card_points
  end

  # add card to hand
  def add_card
    add_card_to_cards(@card.generate_card(@cards))
  end

  # add cards
  def add_card_to_cards(card)
    @cards << card
  end

  # clear hand
  def clear_cards
    @cards = Card.new.cards
  end
end
