require_relative './deck'

# cards in hand
class Hand
  attr_accessor :name, :card, :cards, :card_points

  def initialize(name, deck)
    @name = name
    @deck = deck
    @cards = []
    give_cards
    @card_points = count_points
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
  def add_card
    add_card_to_hand
    @card_points = count_points
  end

  # clear hand
  def clear_cards
    @cards.clear
    give_cards
    @card_points = count_points
  end

  # give cards
  def give_cards
    loop do
      break if @cards.count == 2

      card_sample = @deck.generated_cards.sample

      toggle_card = Card.new(card_sample)
      @cards << toggle_card unless @cards.include?(toggle_card.name)

    end
  end

  # add card
  def add_card_to_hand
    loop do
      break if @cards.count == 3

      card_sample = @deck.generated_cards.sample

      toggle_card = Card.new(card_sample)
      @cards << toggle_card unless @cards.include?(toggle_card.name)
    end
  end
end
