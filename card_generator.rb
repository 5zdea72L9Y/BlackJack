require '../BlackJack/card_checker'
require '../BlackJack/deck'

# generate cards
module CardGenerator
  def self.included(base)
    base.include InstanceMethods
  end

  # instance methods
  module InstanceMethods
    include CardChecker

    @deck = Deck.new
    @@cards_g = @deck.cards
    @@card_suit_g = @deck.suit

    # generate cards
    def generate_cards(cards)
      loop do
        break if cards.count == 2

        # take random cards
        card = @@cards_g.sample
        suit = @@card_suit_g.sample
        card_toggle = "#{card} - #{suit}"
        next unless valid?(card_toggle, cards)

        # count points and write card
        write_card(card_toggle, check_card_point(card))
      end
    end

    # add card
    def add_card_to_hand(cards)
      @@g_cards = []
      loop do
        break if @@g_cards.count == 1

        # take random cards
        card = @@cards_g.sample
        suit = @@card_suit_g.sample
        card_toggle = "#{card} - #{suit}"
        @@g_cards << card_toggle
        next unless valid?(card_toggle, cards)

        # count points and write card
        write_card(card_toggle, check_card_point(card))
      end
      @@g_cards = []
    end

    # check valid
    def valid?(card_toggle, cards)
      validate_cards!(card_toggle, cards)
      true
    rescue StandardError
      false
    end

    private

    def validate_cards!(card_toggle, cards)
      raise if cards.include?(card_toggle)
    end
  end
end
