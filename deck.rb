require_relative './card'

# all cards
class Deck
  attr_reader :generated_cards

  def initialize
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
  end
end
