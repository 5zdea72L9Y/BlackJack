require_relative './user'
require_relative './interface'
require_relative './croupier'
require_relative './deck'

# main class
class Main
  def initialize
    @bank = 0
    @open = false
    @draw = 'draw'
    @again = true
    @i = Interface.new
    @user = User.new(@i.start_msg, 100)
    @croupier = Croupier.new(100)
    start
  end

  private

  # start game
  def start
    loop do
      abort 'bye' unless @again
      abort 'your or croupier balance is 0' if @user.balance.zero? || @croupier.balance.zero?

      @user.hand.clear_cards
      @croupier.hand.clear_cards
      @deck = Deck.new
      2.times { take_card(@user) }
      2.times { take_card(@croupier) }
      @i.cls
      @i.show_balance(@user)
      @i.show_cards(@open, @user, @croupier)

      add_to_bank
      main_method
    end
  end

  # main actions
  def main_method
    @i.cls
    @i.show_balance(@user)
    @i.show_cards(@open, @user, @croupier)
    check_action(@i.action_msg)
  end

  # check end of the game
  def check_end
    action = @i.again_msg

    case action
    when 1
      @i.cls
      return true
    else
      @i.cls
      return false
    end
  end

  # add money to bank
  def add_to_bank
    @user.balance -= 10
    @croupier.balance -= 10
    @bank = 20
  end

  # check user input
  def check_action(action)
    case action
    when 1
      skip_a_turn
    when 2
      add_card_and_check
    when 3
      @open = true
      check_winner
      win_actions
    end
  end

  def add_card_and_check
    take_card(@user)
    take_card(@croupier) if @croupier.move
    @open = true
    check_winner
    win_actions
  end

  # check who win
  def check_winner
    # winner logic
    @winner = @user if (@croupier.card_points < @user.card_points && @user.card_points < 21) || @croupier.card_points > 21 || @user.card_points == 21
    @winner = @croupier if (@croupier.card_points > @user.card_points && @croupier.card_points < 21) || @user.card_points > 21 || @croupier.card_points == 21
    @winner = @draw if @croupier.card_points == @user.card_points
    @winner = @draw if @croupier.card_points > 21 && @user.card_points > 21
    # looser logic
    @looser = @user if @winner == @croupier
    @looser = @croupier if @winner == @user
    @looser = @draw if @croupier.card_points == @user.card_points
    @looser = @draw if @croupier.card_points > 21 && @user.card_points > 21
  end

  # show user who win
  def win_actions
    @i.cls
    @i.show_balance(@user)
    @i.show_cards(@open, @user, @croupier)
    @i.winner_msg(@user, @croupier, @winner) if @winner == @user || @winner == @croupier
    @i.winner_msg(@user, @croupier, @draw) if @winner == @draw

    # balance
    @winner.balance += @bank if @winner == @user || @winner == @croupier
    if @winner == @draw
      @user.balance += 10
      @croupier.balance += 10
    end
    # play again
    if check_end
      @i.cls
      @winner = nil
      @bank = 0
      @open = false
      @loser = nil
      # start new game
    else
      # exit from the program
      @again = false
    end
  end

  # skip a turn
  def skip_a_turn
    take_card(@croupier) if @croupier.move
    take_card(@user) if add?
    @open = true
    check_winner
    win_actions
  end

  def add?
    action = @i.add_card?
    case action
    when 1
      true
    when 0
      false
    else
      false
    end
  end

  def take_card(name)
    card = @deck.give_card
    name.add_card(card)
    name.card_points = name.hand.card_points
  end
end

main = Main.new 

