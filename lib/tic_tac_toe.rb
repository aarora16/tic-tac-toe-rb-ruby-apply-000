board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

$win_symbol = nil


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
  index = input.to_i - 1
end


def move(board, index, value)
  board[index] = value
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
  

def valid_move?(board, index)
  if (0..8).include?(index) && !(position_taken?(board, index))
    return true
  end
  return false
end


def turn(board)
  puts "Please enter 1-9:"
  
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  
  if valid_move?(board, index)
    move(board, index, value)
    return display_board(board)
  end
  turn(board)
end


def help_turn(board, index, value)
  if valid_move?(board, index)
    move(board, index, value)
    return display_board(board)
  end
  turn(board)
end


def play(board)
  count = 0
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  
  until over?(board)
    turn(board)
    if won?(board)
      puts "Congratulations player #{current_player(board)}!"
    end
  end
end


def turn_count(board)
  counter = 0
  board.each do |letter|
    if letter == "X" || letter == "O"
      counter += 1
    end
  end
  
  return counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |combination|
    pos_1 = board[combination[0]]
    pos_2 = board[combination[1]]
    pos_3 = board[combination[2]]

    return combination if winning_combo?([pos_1, pos_2, pos_3])
  end

  return false
end


def winning_combo?(moves)
  unique = moves.uniq

  if unique.size == 1 && unique[0] != " "
    $win_symbol = unique[0]
    return true
  end

  return false
end


def full?(board)
  return board.count("X") + board.count("O") == 9
end


def draw?(board)
  return full?(board) && !won?(board)
end


def over?(board)
  return won?(board) || draw?(board)
end


def winner(board)
  $win_symbol = nil
  won?(board)

  return $win_symbol
end





  
  
  
  
  
  
  
  
  