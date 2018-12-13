require_relative './card'

# all cards
class Deck
  attr_accessor :cards

  def initialize
    @card_values = %w[1 2 3 4 5 6 7 8 9 10 J Q K A]
    @card_suit = %w[diamond spade club heart]
    @cards = []
    @generated_cards = []
    generate_cards
  end

  # generate cards
  def generate_cards
    @card_values.each do |value|
      @card_suit.each do |suit|
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

      card = @generated_cards.sample
      unless @cards.include?(card)
        toggle_card = Card.new(card)
        @cards << toggle_card
      end
    end
  end

  # add card
  def add_card_to_hand
    loop do
      break if @cards.count == 3

      card = @generated_cards.sample
      unless @cards.include?(card)
        toggle_card = Card.new(card)
        @cards << toggle_card
      end
    end
  end
end
