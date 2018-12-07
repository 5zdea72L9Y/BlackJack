require '../BlackJack/hand'

# user class
class User
  attr_reader :name
  attr_accessor :balance, :cards, :hand, :card_points

  def initialize(name, balance=100)
    @name = name if name_valid?(name)
    @hand = Hand.new(@name)
    @balance = balance
    @cards = @hand.user_cards
    @card_points = @hand.user_card_points
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
