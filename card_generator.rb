require './card_checker'

# generate cards
module CardGenerator
  def self.included(base)
    base.include InstanceMethods
  end

  # instance methods
  module InstanceMethods
    include CardChecker

    @@cards_g = %w[1 2 3 4 5 6 7 8 9 10 J Q K A]
    @@card_suit_g = %w[diamond spade club heart]

    # generate cards
    def generate_cards
      loop do
        break if @cards.count == 2

        # take random cards
        card = @@cards_g.sample
        suit = @@card_suit_g.sample
        card_toggle = "#{card} - #{suit}"
        next unless valid?(card_toggle)

        @cards << card_toggle
        # count points
        check_card_point(card)
      end
    end

    # add card
    def add_card
      loop do
        break if @cards.count == 3

        # take random cards
        card = @@cards_g.sample
        suit = @@card_suit_g.sample
        card_toggle = "#{card} - #{suit}"
        next unless valid?(card_toggle)

        @cards << card_toggle
        # count points
        check_card_point(card)
      end
    end

    # check valid
    def valid?(card_toggle)
      validate_cards!(card_toggle)
      true
    rescue StandardError
      false
    end

    private

    def validate_cards!(card_toggle)
      raise if @cards.include?(card_toggle)
    end
  end
end
