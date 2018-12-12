require_relative './card'

# all cards
class Deck
  attr_accessor :cards

  def initialize
    @card_values = %w[1 2 3 4 5 6 7 8 9 10 J Q K A]
    @card_suit = %w[diamond spade club heart]
    @cards = []

    generate_cards
  end

  # generate cards
  def generate_cards
    loop do
      break if @cards.count == 2

      # take random cards
      card = @card_values.sample
      suit = @card_suit.sample
      card_toggle = "#{card} - #{suit}"
      next unless valid?(card)

      # count points and write card
      new_card = Card.new(card_toggle)
      @cards << new_card
    end
  end

  # add card
  def add_card_to_hand(cards)
    loop do
      break if cards.count == 3

      # take random cards
      card = @card_values.sample
      suit = @card_suit.sample
      card_toggle = "#{card} - #{suit}"
      next unless valid?(card)

      # count points and write card
      new_card = Card.new(card_toggle)
      @cards << new_card
    end
  end

  # check valid
  def valid?(card)
    validate_cards!(card)
    true
  rescue StandardError
    false
  end

  private

  def validate_cards!(card)
    raise if @cards.include?(card)
  end
end
