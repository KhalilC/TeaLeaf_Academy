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
    @player = Player.new("Khalil")
    @dealer = Player.new("Dealer")
    @deck = Deck.new
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

  def play
    display_intro
    # deal card to player and dealer
    2.times do 
      player.hand << deal_card
      dealer.hand << deal_card
    end
    display_hand(player.hand, player)
    display_hand(dealer.hand, dealer)

  end

end

game = Blackjack.new
game.play