require_relative './hand'

# user class
class User
  attr_reader :name
  attr_accessor :balance, :cards, :hand, :card_points

  def initialize(name, balance)
    @name = name if name_valid?(name)
    @name = 'looser' unless name_valid?(name)
    @hand = Hand.new(@name)
    @balance = balance
    @cards = @hand.cards
    @card_points = @hand.card_points
  end

  def name_valid?(name)
    validate_name!(name)
    true
  rescue StandardError
    false
  end

  def add_card(card)
    @hand.add_card(card)
    @card_points = @hand.card_points
  end

  private

  def validate_name!(name)
    raise 'blank или nil' if name.to_s.empty?
  end
end
