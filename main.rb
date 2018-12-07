require '../BlackJack/user'
require '../BlackJack/croupier'
require '../BlackJack/interface'

# main class
class Main
  def initialize
    @user = nil
    @croupier = nil
    @bank = 0
    @open = false
    @winner = nil
    @loser = nil
    @i = Interface.new
  end

  # start
  def start
    # create user and croupier

    @user = User.new(@i.start_msg)
    @i.cls
    @croupier = Croupier.new
    start_game
  end

  private

  # start game
  def start_game
    # generate cards

    new_user = User.new(@user.name, @user.balance)
    @user = new_user

    new_croupier = Croupier.new(@croupier.balance)
    @croupier = new_croupier
    add_to_bank
    # check user actions
    main_method
  end

  # main actions
  def main_method
    loop do
      @i.cls
      raise 'zero balance' if @user.balance.zero? || @croupier.balance.zero?

      @i.show_balance(@user, @croupier)
      @i.show_cards(@open, @user, @croupier)
      # user action
      action

      next unless @winner

      win_actions
      # default values
      @winner = nil
      @bank = 0
      @open = false
      @loser = nil
      # play again
      if check_end
        @i.cls
        start_game
      else
        raise 'bye'
      end
    end
  end

  def skip_croupier
    @i.cls
    @i.show_balance(@user, @croupier)
    @i.show_cards(@open, @user, @croupier)
    action
  end

  # user actions
  def action
    answers
    @i.cls
    @i.show_balance(@user, @croupier)
    @i.show_cards(@open, @user, @croupier)
  end

  # user answer
  def answers
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
      @i.skip
      sleep(2)
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
    @user.hand.add_card(@user.name)
    @user.card_points = @user.hand.card_user.card_points
    @open = true
    check_winner
    win_actions
  end

  # check who win
  def check_winner
    # winner logic
    @winner = @user if @croupier.card_points < @user.card_points || @croupier.card_points > 21
    @winner = @croupier if @croupier.card_points > @user.card_points || @user.card_points > 21
    @winner = nil if @croupier.card_points == @user.card_points
    @winner = nil if @croupier.card_points > 21 && @user.card_points > 21
    # loser logic
    @loser = @user if @winner == @croupier
    @loser = @croupier if @winner == @user
    @loser = nil if @croupier.card_points == @user.card_points
    @loser = nil if @croupier.card_points > 21 && @user.card_points > 21
  end

  # show user who win
  def win_actions
    @i.winner_msg(@user, @croupier, @winner)

    # balance
    @winner.balance += @bank if @winner
  end

  # skip a turn
  def skip_a_turn
    skip_croupier unless @croupier.move
  end
end

main = Main.new

main.start