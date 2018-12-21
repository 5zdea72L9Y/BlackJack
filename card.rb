# one card
class Card
  attr_reader :name, :points

  CARD_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  CARD_SUIT = %w[♠ ♣ ♥ ♦]

  def initialize(card)
    @name = card
    count_points
  end

  class << self
    def card_values
      CARD_VALUES
    end

    def card_suit
      CARD_SUIT
    end
  end

  # count points
  def count_points
    if number?
      points = @name[0] + @name[1]
      @points = points.to_i
    end
    @points = 10 if picture?
    @points = 11 if ace?
  end

  # check ace
  def ace?
    @name.chars.first == 'A'
  end

  # check number
  def number?
    !@name.chars.first.to_i.zero?
  end

  # check picture
  def picture?
    %w[J Q K].include?(@name.chars.first)
  end
end
