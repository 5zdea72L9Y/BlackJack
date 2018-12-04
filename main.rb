require './user'
require './croupier'

# main class
class Main
  def initialize
    @user = nil
    @croupier = nil
    @bank = 0
    @open = false
    @winner = nil
    @loser = nil
  end

  # start
  def start
    # create user and croupier
    puts 'Enter name please: '
    name = gets.chomp.to_s
    @user = User.new(name)
    cls
    @croupier = Croupier.new
    start_game
  end

  private

  # start game
  def start_game
    # generate cards
    @user.cards.clear
    @croupier.cards.clear
    @user.card_points = 0
    @croupier.card_points = 0
    @user.generate_cards
    @croupier.generate_cards
    add_to_bank
    # check user actions
    main_method
  end

  # main actions
  def main_method
    loop do
      cls
      raise 'zero balance' if @user.balance.zero? || @croupier.balance.zero?

      show_balance
      show_cards(@open)
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
        cls
        start_game
      else
        raise 'bye'
      end
    end
  end

  # user actions
  def action
    answers
    cls
    show_balance
    show_cards(@open)
  end

  # show user balance and points
  def show_balance
    puts "Name: #{@user.name}, balance: #{@user.balance}, points: #{@user.card_points}"
  end

  # user answer
  def answers
    puts "Enter action:
    1 - skip a turn
    2 - add card
    3 - open cards
    "
    action = gets.chomp.to_i
    check_action(action)
  end

  # clear console
  def cls
    system('clear')
  end

  # check end of the game
  def check_end
    puts 'Play again?(1/0)'
    action = gets.chomp.to_i

    case action
    when 1
      cls
      return true
    when 0
      cls
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

  # show croupier and user cards
  def show_cards(open)
    show_user_cards

    show_croupier_cards(open)
  end

  # user cards
  def show_user_cards
    puts 'Your cards: '
    @user.cards.each do |card|
      puts card
    end
  end

  # open or close cards
  def show_croupier_cards(open)
    open ? open_cards : close_cards
  end

  # show croupier cards
  def open_cards
    puts 'Croupier cards: '
    @croupier.cards.each do |card|
      puts card
    end
  end

  # close croupier cards
  def close_cards
    puts 'Croupier cards: '
    @croupier.cards.count.times do
      card = '*'
      puts card
    end
  end

  # check user input
  def check_action(action)
    case action
    when 1
      puts 'skip..'
      sleep(2)
      skip_a_turn
    when 2
      add_card
      # open cards auto
      if @user.check_cards
        @open = true
        check_winner
        win_actions
      end
    when 3
      @open = true
      check_winner
      win_actions
    end
  end

  # add card
  def add_card
    @user.add_card
    @croupier.move
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
    puts "User points: #{@user.card_points}, croupier points: #{@croupier.card_points}"
    puts "Winner: #{@winner.name} \n" if @winner
    puts "Draw \n" unless @winner

    # balance
    @winner.balance += @bank if @winner
  end

  # skip a turn
  def skip_a_turn
    main_method unless @croupier.move
  end
end

main = Main.new

main.start
