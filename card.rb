# one card
class Card
  attr_accessor :name, :points

  def initialize(card, points)
    @name = card
    @points = points
  end
end
