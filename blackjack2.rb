# second version of procedural blackjack

def calculate_total(hand)
  total = 0
  aces = 0
  hand.each do |card|
    if card[0] == "A"
      total += 11
      aces += 1
    else
      card[0].to_i == 0 ? total += 10 : total += card[0].to_i
    end
  end
  # adjust for aces
  while total > 21 && aces >= 1
    total -= 10
    aces -= 1
  end
  total
end

def display_hand(hand, dealer = '')
  player_or_dealer = (dealer.empty? ? "Your hand: " : "Dealer's hand")
  puts player_or_dealer
  hand.each { |card| print card }
  print " Total: #{calculate_total(hand)}"
  puts
end

# start of game 
puts "Welcome to Blackjack!"
puts "Dealer stays on 17"
puts "Press enter to continue"
gets
SUITS = %w(H S C D)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)
BLACKJACK = 21
system 'clear'
play_again = ''
deck = VALUES.product(SUITS).shuffle!
while play_again != 'n'
  system 'clear'
  player_hand = []
  dealer_hand = []
  natural_blackjack = false
  2.times do
    player_hand << deck.pop
    dealer_hand << deck.pop
  end
  puts "Your hand:"
  player_hand.each { |card| print card }
  print " Total: #{calculate_total(player_hand)}"
  puts "\nDealer hand: "
  print "['X', 'X']"
  p dealer_hand[1]
  # player turn
  if calculate_total(player_hand) == BLACKJACK && calculate_total(dealer_hand) != BLACKJACK
    puts "Natural blackjack!  You win!"
    natural_blackjack = true
  else
    while calculate_total(player_hand) < BLACKJACK
      puts "Hit or stay?(h/s)"
      choice = gets.chomp.downcase
      next unless ['h', 's'].include?(choice)
      break if choice == 's'
      system 'clear'
      player_hand << deck.pop
      display_hand(player_hand)
      puts "Dealer hand: "
      print "['X', 'X']"
      p dealer_hand[1]
    end
  end
  # dealer turn
  if (calculate_total(player_hand) <= BLACKJACK) && !natural_blackjack
    puts "Press enter to see Dealer's hidden card"
    gets
    system 'clear'
    display_hand(player_hand)
    display_hand(dealer_hand, "Dealer")
    while calculate_total(dealer_hand) < 17
      puts "Press enter to see dealer's next card"
      gets
      system 'clear'
      dealer_hand << deck.pop
      display_hand(player_hand)
      display_hand(dealer_hand, "Dealer")
    end
  end
  # results besides natural blackjack
  if calculate_total(player_hand) > BLACKJACK
    puts "You busted!  Better luck next time."
  elsif calculate_total(dealer_hand) > BLACKJACK
    puts "Dealer busted with a total of #{calculate_total(dealer_hand)}. You win!"
  elsif (calculate_total(player_hand) > calculate_total(dealer_hand)) && !natural_blackjack
    puts "You win!  You have #{calculate_total(player_hand)} and the dealer has #{calculate_total(dealer_hand)}"
  elsif calculate_total(dealer_hand) > calculate_total(player_hand)
    puts "You lose!  Dealer has #{calculate_total(dealer_hand)} and you have #{calculate_total(player_hand)}"
  elsif calculate_total(dealer_hand) == calculate_total(player_hand)
    puts "It's a tie! You have #{calculate_total(player_hand)} and the dealer has #{calculate_total(dealer_hand)}"
  end
  loop do
    puts "Play again?(y/n)"
    play_again = gets.chomp.downcase
    break if ['y', 'n'].include?(play_again)
  end
end

puts "Thanks for playing.  Goodbye!"
