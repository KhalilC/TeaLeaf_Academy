#tic tac toe

def draw_board(board)
  system 'clear'
  puts "  #{board[1]} | #{board[2]} | #{board[3]}"
  puts " -----------"
  puts "  #{board[4]} | #{board[5]} | #{board[6]}"
  puts " ----------- "
  puts "  #{board[7]} | #{board[8]} | #{board[9]}"
end

def initialize_board
  board = {}
  (1..9).each {|position| board[position] = ' '}
  board
end

def player_pick(board, open_squares)
  puts "Choose a square(1-9): "
  player_square = gets.chomp.to_i
  if !open_squares.include?(player_square)
    begin
      puts "Not a valid choice.  Try again! (1-9)"
      player_square = gets.chomp.to_i
    end until open_squares.include?(player_square)
  end
  open_squares.delete(player_square)
  board[player_square] = 'X'
end

def computer_pick(board, open_squares)
  return if open_squares.empty? || winner(board)
  computer_choice = open_squares.sample
  open_squares.delete(computer_choice)
  board[computer_choice] = 'O'
end

def winner(board)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|  
    return "You win!" if board.values_at(*line).count('X') == 3
    return "Computer won!" if board.values_at(*line).count('O') == 3
    end
    nil
  end

available_squares = (1..9).to_a
board = initialize_board
begin
draw_board(board)
player_pick(board, available_squares)
computer_pick(board, available_squares)
draw_board(board)
end until winner(board) || available_squares.empty?
puts winner(board) if winner(board)
puts "It's a tie" unless winner(board)

