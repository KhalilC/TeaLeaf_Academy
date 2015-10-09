# object oriented rock paper scissors

class Player
  attr_accessor :name, :hand
  def initialize(name)
    @name = name
  end

  def to_s
    "#{name} chose #{Game::CHOICES[hand.value]}"
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Choose rock, paper, scissors(r/p/s)"
      choice = gets.chomp
    end until Game::CHOICES.keys.include?(choice)
    self.hand = Hand.new(choice)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end


class Hand
  include Comparable
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') || (@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end
end

class Game
  attr_accessor :player, :computer
  CHOICES = { 'r' => 'rock', 'p' => 'paper', 's' => 'scissors' }

  def initialize
    @player = Human.new("Khalil")
    @computer = Computer.new("Computer")
  end

  def compare_hands
    if player.hand == computer.hand
      puts "It's a tie!"
    elsif player.hand > computer.hand
      puts "You win!"
    else
      puts "You lose!"
    end

  end

  def play_again?
    begin
      puts "Play again?(y/n)"
      answer = gets.chomp.downcase
    end until %w(y n).include?(answer)
    answer
  end

  def run
    system 'clear'
    puts "Welcome to rock paper scissors."
    loop do
      player.pick_hand
      computer.pick_hand
      puts player
      puts computer
      compare_hands
    break if play_again? == 'n'
    end
  end
end

game = Game.new
game.run
