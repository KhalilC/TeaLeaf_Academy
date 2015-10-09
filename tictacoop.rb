# object oriented tic tac toe

class Player
  attr_reader :marker, :name
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Square
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end
end

class Board
  attr_accessor :data
  def initialize
    @data = {}
    (1..9).each { |number| @data[number] = Square.new(' ') }
  end

  def draw
    system 'clear'
    puts
    puts "       |       |"
    puts "  #{@data[1]}    |  #{@data[2]}    |   #{@data[3]}"
    puts "       |       |"
    puts "-------+-------+------"
    puts "       |       |"
    puts "  #{@data[4]}    |  #{@data[5]}    |   #{@data[6]}"
    puts "       |       |"
    puts "-------+-------+------"
    puts "       |       |"
    puts "  #{@data[7]}    |  #{@data[8]}    |   #{@data[9]}"
    puts "       |       |"
    puts
  end

  def empty_squares
    @data.select { |_, square| square.value == ' ' }.keys
  end
end

class TicTacToe
  attr_accessor :board, :current_player, :human, :computer
  def initialize
    @human = Player.new("Khalil", 'X')
    @computer = Player.new("Computer", 'O')
    @board = Board.new
    @current_player = @human
  end

  def player_or_computer_pick_square
    if current_player == human
      begin
        puts "Pick a square (1-9)"
        choice = gets.chomp.to_i
      end until board.empty_squares.include?(choice)
      board.data[choice] = Square.new(human.marker)
    else
      computer_pick = board.empty_squares.sample
      board.data[computer_pick] = Square.new(computer.marker)
    end
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def check_for_winner
    winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    winning_lines.each do |line|
      return "Player" if board.data[line[0]].value == human.marker && board.data[line[1]].value == human.marker && board.data[line[2]].value == human.marker
      return "Computer" if board.data[line[0]].value == computer.marker && board.data[line[1]].value == computer.marker && board.data[line[2]].value == computer.marker
    end
    nil
  end

  def run
    board.draw
    loop do
      player_or_computer_pick_square
      board.draw
      break if check_for_winner
      alternate_player
      break if board.empty_squares.empty?
    end
    if check_for_winner
      puts "#{check_for_winner} won!"
    else
      puts "It's a tie!"
    end
  end
end

game = TicTacToe.new
game.run
