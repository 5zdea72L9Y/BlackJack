require '../BlackJack/card'
# card in hand
class Hand
  attr_accessor :card_user, :card_croupier
  attr_accessor :user_cards, :croupier_cards, :user_card_points, :croupier_card_points

  def initialize(name)
    @name = name
    @card_user = Card.new
    @card_croupier = Card.new
    if @name == 'croupier'
      @croupier_cards = @card_croupier.cards
      # check empty
      if @card_croupier.card_points.zero?
        @croupier_card_points = 0
      else
        @croupier_card_points = @card_croupier.card_points
      end
    else
      @user_cards = @card_user.cards
      #check empty
      if @card_user.card_points.zero?
        @user_card_points = 0
      else
        @user_card_points = @card_user.card_points
      end
    end
  end

  # add card to hand
  def add_card(name)
    if name == 'croupier'
      add_card_to_croupier(@card_croupier.generate_card(@card_croupier.cards))
    else
      add_card_to_user(@card_user.generate_card(@card_user.cards))
    end
  end

  # add card(user)
  def add_card_to_user(card)
    @user_cards << card
  end

  # add card(croupier)
  def add_card_to_croupier(card)
    @croupier_cards << card
  end

  # clear hand
  def clear_cards
    user_new = Card.new
    croupier_new = Card.new
    @user_cards = user_new.cards
    @croupier_cards = croupier_new.cards
  end
end
