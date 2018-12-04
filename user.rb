require './card_generator'
require './card_checker'

# user class
class User
  include CardGenerator
  include CardChecker

  attr_reader :name
  attr_accessor :balance, :cards, :card_points

  def initialize(name)
    @name = name if name_valid?(name)
    @balance = 100
    @cards = []
    @card_points = 0
  end

  # check for 3 cards
  def check_cards
    return true if @cards.count == 3
  end

  private

  def name_valid?(name)
    validate_name!(name)
    true
  rescue StandardError
    false
  end

  def validate_name!(name)
    raise 'blank или nil' if name.to_s.empty?
  end
end
