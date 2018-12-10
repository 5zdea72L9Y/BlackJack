class Interface
  # clear console
  def cls
    system('clear')
  end

  # start msg
  def start_msg
    puts 'Enter name please: '
    name = gets.chomp.to_s
  end

  # show user balance and points
  def show_balance(user)
    puts "Name: #{user.name}, balance: #{user.balance}, points: #{user.card_points}"
  end

  # show cards
  def show_cards(open, user, croupier)
    show_user_cards(user)

    open ? open_cards(croupier) : close_cards(croupier)
  end

  # user cards
  def show_user_cards(user)
    puts 'Your cards: '
    user.cards.each do |card|
      puts card.name
    end
  end

  # show croupier cards
  def open_cards(croupier)
    puts 'Croupier cards: '
    croupier.cards.each do |card|
      puts card.name
    end
  end

  # close croupier cards
  def close_cards(croupier)
    puts 'Croupier cards: '
    croupier.cards.count.times do
      card = '*'
      puts card
    end
  end

  def action_msg
    puts "Enter action:
    1 - skip a turn
    2 - add card
    3 - open cards
    "
    action = gets.chomp.to_i
  end

  def again_msg
    puts 'Play again?(1/0)'
    action = gets.chomp.to_i
  end

  def winner_msg(user, croupier, winner)
    puts "User points: #{user.card_points}, croupier points: #{croupier.card_points}"
    puts "Winner: #{winner.name} \n" if winner == user || winner == croupier
    puts "Draw \n" if winner == 'draw'
  end
end
