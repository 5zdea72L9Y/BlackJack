require_relative './user'
require_relative './interface'
require_relative './croupier'

# main class
class Main
  def initialize(user=nil, croupier=nil, again)
    @bank = 0
    @open = false
    @draw = 'draw'
    @i = Interface.new
    start unless again
    start_again(user, croupier) if again
  end

  private

  # start game
  def start
    @user = User.new(@i.start_msg, 100)
    @i.cls
    @croupier = Croupier.new(100)
    add_to_bank
    main_method
  end

  # start again
  def start_again(user, croupier)
    # generate cards
    @user = User.new(user.name, user.balance)
    @croupier = Croupier.new(croupier.balance)
    add_to_bank
    # check user actions
    main_method
  end

  # main actions

  def main_method
    @i.cls
    abort 'your or croupier balance is 0' if @user.balance.zero? || @croupier.balance.zero?

    @i.show_balance(@user)
    @i.show_cards(@open, @user, @croupier)
    check_action(@i.action_msg)
  end

  def skip_croupier
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
    when 0
      @i.cls
      return false
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
      add_card
    when 3
      @open = true
      check_winner
      win_actions
    end
  end

  # add card
  def add_card
    @user.hand.add_card
    @user.card_points = @user.hand.card_points
    @croupier.move
    @open = true
    check_winner
    win_actions
  end

  # check who win
  def check_winner
    # winner logic
    @winner = @user if (@croupier.card_points < @user.card_points && @user.card_points < 21) || @croupier.card_points >= 21 || @user.card_points == 21
    @winner = @croupier if (@croupier.card_points > @user.card_points && @croupier.card_points < 21) || @user.card_points >= 21 || @croupier.card_points == 21
    @winner = @draw if @croupier.card_points == @user.card_points
    @winner = @draw if @croupier.card_points > 21 && @user.card_points > 21
    # loser logic
    @loser = @user if @winner == @croupier
    @loser = @croupier if @winner == @user
    @loser = @draw if @croupier.card_points == @user.card_points
    @loser = @draw if @croupier.card_points > 21 && @user.card_points > 21
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
      Main.new(@user, @croupier, true)
    else
      # exit from the program
      abort 'bye'
    end
  end

  # skip a turn
  def skip_a_turn
    skip_croupier unless @croupier.move
  end
end

main = Main.new(false)

