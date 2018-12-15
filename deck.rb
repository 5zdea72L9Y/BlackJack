require_relative './card'

# all cards
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    @generated_cards = []
    generate_cards
  end

  # generate cards
  def generate_cards
    Card.card_values.each do |value|
      Card.card_suit.each do |suit|
        card = "#{value} - #{suit}"
        @generated_cards << card
      end
    end
    give_cards
  end

  # give cards
  def give_cards
    loop do
      break if @cards.count == 2

      card_sample = @generated_cards.sample

      toggle_card = Card.new(card_sample)
      @cards << toggle_card unless @cards.include?(toggle_card.name)

    end
  end

  # add card
  def add_card_to_hand
    loop do
      break if @cards.count == 3

      card_sample = @generated_cards.sample

      toggle_card = Card.new(card_sample)
      @cards << toggle_card unless @cards.include?(toggle_card.name)
    end
  end

  # clear cards
  def clear
    @cards.clear
    give_cards
  end
end
