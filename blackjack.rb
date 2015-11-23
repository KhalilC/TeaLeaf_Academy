#blackjack

SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"]
VALUES = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']
BLACKJACK = 21

def create_deck(suits, values, number_of_decks)
  deck = []
  number_of_decks.times {deck += values.product(suits)}
  deck.shuffle!
end

# player can choose number of decks
def get_number_of_decks
  number_of_decks = (1..4).to_a
  answer = gets.chomp.to_i
  if !number_of_decks.include?(answer)
    begin
      puts "Not a valid choice.  How many decks?(1-4)"
      answer = gets.chomp.to_i
    end until number_of_decks.include?(answer)
  end
  answer
end

def deal_cards(deck, player_or_dealer_hand)
  player_or_dealer_hand << deck.pop
end

def get_initial_hands(deck, player_hand, dealer_hand)
  2.times do
  deal_cards(deck, player_hand)
  deal_cards(deck, dealer_hand)
  end
end

def display_hand(player_or_dealer_hand, player_or_dealer)
  puts "#{player_or_dealer}'s cards: " if player_or_dealer != "Dealer"
  puts "Dealer's cards: " if player_or_dealer == "Dealer"
  player_or_dealer_hand.each do |card|
    print card
  end
  print " Total: #{calc_hand_total(player_or_dealer_hand)}"
  puts
end

def hide_dealer_first_card(dealer_hand)
  puts "Dealer's cards: "
  dealer_hand.each_with_index do |card, index|
    if index == 0
      print '["X", "X"]'
    else
      print card
    end
  end
  puts
end

def calc_hand_total(player_or_dealer_hand)
  total = 0
  number_of_aces = 0
  player_or_dealer_hand.each do |card|
    if card[0] == "A"
      total += 11
      number_of_aces += 1
    else
      card[0].to_i != 0 ? total += card[0].to_i : total += 10
    end
  end
  # adjust for aces if total > 21
  if total > 21 && number_of_aces >= 1
    begin 
    total -= 10
    number_of_aces -= 1
    end until total <= 21 || number_of_aces == 0
  end
  total
end

def is_busted?(player_or_dealer_hand)
  calc_hand_total(player_or_dealer_hand) > BLACKJACK
end

def player_turn(player_hand, hand_total, deck, player_name, dealer_hand)
  return if calc_hand_total(player_hand) == BLACKJACK
  loop do
  begin
  puts "Hit or stand?(Enter 'h' or 's')"
  player_choice = gets.chomp
  end until ['h', 's'].include?(player_choice)
  break if player_choice == 's'
  deal_cards(deck, player_hand) if player_choice == 'h'
  system 'clear'
  display_hand(player_hand, player_name)
  hide_dealer_first_card(dealer_hand)
  break if is_busted?(player_hand) || calc_hand_total(player_hand) == BLACKJACK
  end
end

def clear_screen_between_dealer_cards(player_hand, player_name, dealer_hand, dealer_name)
  system 'clear'
  display_hand(player_hand, player_name)
  display_hand(dealer_hand, dealer_name)
end

def dealer_turn(dealer_hand, deck, dealer_name, player_name, player_hand)
  puts "Press enter to see dealer's hidden card"
  gets
  clear_screen_between_dealer_cards(player_hand, player_name, dealer_hand, dealer_name)
  return if calc_hand_total(dealer_hand) >= 17
  begin
  puts "Press enter to see dealer's next card: "
  gets
  deal_cards(deck, dealer_hand)
  clear_screen_between_dealer_cards(player_hand, player_name, dealer_hand, dealer_name)
  end until calc_hand_total(dealer_hand) >= 17 || is_busted?(dealer_hand)
end

def result(player_hand, dealer_hand, player_name, dealer_name)
  if calc_hand_total(dealer_hand) > BLACKJACK
    puts "Dealer busted!  You win!" 
  elsif calc_hand_total(player_hand) > calc_hand_total(dealer_hand)
    puts "#{player_name} wins with a total of #{calc_hand_total(player_hand)} versus the dealer's #{calc_hand_total(dealer_hand)}!"
  elsif calc_hand_total(dealer_hand) > calc_hand_total(player_hand)
    puts "#{player_name} loses!  Dealer has #{calc_hand_total(dealer_hand)} and #{player_name} has #{calc_hand_total(player_hand)}!"
  else
    puts "It's a tie!  #{player_name} has #{calc_hand_total(player_hand)} and the dealer has #{calc_hand_total(dealer_hand)}"
  end
end

def play_again?
  begin
  puts "Play again(y/n)?"
  answer = gets.chomp.downcase
  end until ['y','n'].include?(answer)
  answer
end

system 'clear'
puts "Welcome to Blackjack!"
puts "Dealer stays on 17"
puts "What is your name? "
player_name = gets.chomp
system 'clear'
puts "Hi #{player_name}, this is the only blackjack game where we allow you the player to decide how many decks you want to play with!"
puts "How many decks(1-4)?"
deck = create_deck(SUITS,VALUES, get_number_of_decks)
dealer_name = "Dealer"
loop do
  system 'clear'
  player_hand = []
  dealer_hand = []
  get_initial_hands(deck, player_hand, dealer_hand)
  display_hand(player_hand, player_name)
  hide_dealer_first_card(dealer_hand)
  player_turn(player_hand, calc_hand_total(player_hand), deck, player_name, dealer_hand)
  # if first two cards total 21 and the dealer's do not
  if calc_hand_total(player_hand) == BLACKJACK && calc_hand_total(dealer_hand) != BLACKJACK  && player_hand.count == 2
    puts "Natural Blackjack!  You win!"
  elsif is_busted?(player_hand)
    puts "Busted!  Better luck next time!"
  else
    dealer_turn(dealer_hand, deck, dealer_name, player_name, player_hand)
    result(player_hand, dealer_hand, player_name, dealer_name)
  end
  break if play_again? == 'n'
end

puts "Thanks for playing.  Goodbye!"




