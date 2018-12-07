require '../BlackJack/card_generator'
require '../BlackJack/card_checker'
# card actions
class Card
  include CardGenerator

  attr_accessor :cards, :card_points

  def initialize
    @cards = []
    @card_points = 0
    # generate 2 cards
    generate(@cards)
  end

  # write card points
  def write_points(points)
    @card_points += points
  end

  # add card to @cards
  def write_card(card, points)
    @cards << card if @cards.count <= 2
    write_points(points)
  end

  # generate cards
  def generate(cards)
    generate_cards(cards)
  end

  # generate 3 card
  def generate_card(cards)
    add_card_to_hand(cards)
  end
end
