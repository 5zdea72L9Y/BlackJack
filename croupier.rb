require './card_generator'
require './card_checker'

# croupier class
class Croupier
  include CardGenerator
  include CardChecker

  attr_reader :name
  attr_accessor :balance, :cards, :card_points

  def initialize
    @name = 'croupier'
    @balance = 100
    @cards = []
    @card_points = 0
  end

  def move
    @card_points < 17 ? add_card : skip
  end

  def skip
    false
  end
end
