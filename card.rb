# one card
class Card
  attr_reader :name, :points

  def initialize(card)
    @name = card
    count_points
  end

  # count points
  def count_points
    @points = @name.chars.first.to_i if number?
    @points = 10 if picture?
    @points = 11 if ace?
  end

  # check ace
  def ace?
    @name.chars.first == 'A'
  end

  # check number
  def number?
    @name.to_i.zero? ? false : true
  end

  # check picture
  def picture?
    %w[J Q K].include?(@name.chars.first) ? true : false
  end

  # card name
  def to_s
    @name
  end
end
