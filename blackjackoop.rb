# object oriented blackjack
SUITS = ['s','c','d','h']
VALUES = %w{2 3 4 5 6 7 8 9 10 J Q K A}

class Player
  attr_accessor :hand
  attr_reader :name
  def initialize(name)
    @name = name
    @hand = []
  end

end

class Card
  attr_reader :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "The #{value} of #{convert}"
  end

  def convert
    case suit
    when "s"
      then "spades"
    when "h"
      then "hearts"
    when "c"
      then "clubs"
    when "d"
      then "diamonds"
    end
  end

end

class Deck
  attr_accessor :deck
  def initialize
    @deck = SUITS.map do |suit|
      VALUES.map do |value|
        Card.new(suit, value)
      end
    end.flatten.shuffle!
  end
end

class Blackjack
  attr_accessor :player, :dealer, :deck
  def initialize
    display_intro
    @player = Player.new(get_player_name)
    @dealer = Player.new("Dealer")
    @deck = Deck.new
  end

  def get_player_name
    puts "What is your name?"
    answer = gets.chomp
    answer
  end

  def display_intro
    puts "Welcome to Blackjack!"
    puts "Press enter to play!"
    gets.chomp
  end

  def deal_card
    deck.deck.pop
  end

  def display_hand(hand, player_or_dealer)
    puts "#{player_or_dealer.name}'s hand: "
    hand.each { |card| puts card}
    puts "Total: #{calculate_total(player_or_dealer.hand)}"
  end

  def calculate_total(hand)
    total = 0
    total_aces = 0
    hand.each do |card|
    if card.value == "A"
      total_aces += 1
      total += 11
    else
      card.value.to_i == 0 ? total += 10 : total += card.value.to_i
    end
  end
    # adjust for aces and > 21
    while total_aces > 0 && total > 21
      total -= 10
      total_aces -= 1
    end
    total
  end 

  def busted?(player_or_dealer)
    calculate_total(player_or_dealer.hand) > 21
  end

  def player_turn
    loop do
      begin
      puts "Hit or Stay?(h/s)"
      choice = gets.chomp.downcase
      end until ['h', 's'].include?(choice)
      if choice == 'h'
        system 'clear'
        player.hand << deal_card
        display_hand(player.hand, player)
      end
      break if choice == 's' || busted?(player)
    end
  end

  def dealer_turn
    loop do
      break if calculate_total(dealer.hand) >= 17
      puts "Press enter to see dealer's next card"
      gets.chomp
      dealer.hand << deal_card
      system 'clear'
      display_hand(dealer.hand, dealer)
    end
  end
  # outcome of game
  def win_lose_draw
    return "You busted!" if calculate_total(player.hand) > 21
    return "Dealer busted!" if calculate_total(dealer.hand) > 21
    return "You win!  You have #{calculate_total(player.hand)} and dealer has #{calculate_total(dealer.hand)}" if calculate_total(player.hand) > calculate_total(dealer.hand)
    return "It's a tie.  You and dealer both have #{calculate_total(player.hand)}" if calculate_total(player.hand) == calculate_total(dealer.hand)
    return "You lose!  Dealer has #{calculate_total(dealer.hand)} and you have #{calculate_total(player.hand)}"
  end
  def play_again?
    begin
      puts "Play again?(y/n)?"
      answer = gets.chomp.downcase
    end until ['y','n'].include?(answer)
    answer
  end
  
  def play
    loop do
      player.hand = []
      dealer.hand = []
      2.times do 
        player.hand << deal_card
        dealer.hand << deal_card
      end
      system 'clear'
      display_hand(player.hand, player)
      display_hand(dealer.hand, dealer)
      player_turn
      dealer_turn unless busted?(player)
      system 'clear'
      display_hand(player.hand, player)
      display_hand(dealer.hand, dealer)
      puts win_lose_draw
      break if play_again? == 'n'
    end
    puts "Thanks for playing.  Goodbye!"
  end
end

game = Blackjack.new
game.play