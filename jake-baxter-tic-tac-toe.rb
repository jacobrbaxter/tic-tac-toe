class Board #create a new global class defining the board we'll play on
  

  def start #define a method for making the 3x3 tic tac toe grid
    @board = Array.new(3) { Array.new(3, " ")}
  end

def printinstructions #shows the player the grid below to begin the game
  puts '1 | 2 | 3',
       '---------'
       '4 | 5 | 6',
       '---------'
       '7 | 8 | 9'
  print "\n"
end

def printboard # creating rows vs columns to mark x's and o's in
  (0..2).each do |row|
    print '       '
    (0..2).each do |col|
      print @board[row][col]
      print " | " unless col == 2
    end

    print "\n"
    print "        ---------\n" unless row == 2
  end

  print "\n"
end

# creating a method to decide what happens in a tie
def isTie 
  @board.join.split('').include?("")
end

#creating a method to determine which player won the game
def findWinner
  #this describes a winning scenerio vertically or horizontally
  # X X X        X
  #         &    X
  #              X

  (0..2).each do |i|
if @board[i][0] == @board[i][1] & @board[i][1] == @board[i][2]
  return @board[i][0] unless @board[0][i] == " "


elsif @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i]
  return @board[0][i] unless @board[0][i] == " "

end
end

#the following chunk of code will describe the below winning scenario for the 'x' player
# X                   X
#   X       &       X
#     X           X

if ( @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] )  ||
   ( @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] )
   return @board[1][1] unless @board[1][1] == " "
 end

#Next we'll describe what will happen in the below tie scenario 
# X 0 X
# X 0 X
# 0 X 0


return 'C' unless isTie

return false
end

# So far we've only described what happens in a winning and losing scenario. Now we will write code to determine what happens with the users input

#first we set up an empty tic tac toe board to begin the game
def is_empty(row,col)
  @board[row][col] === " "
end

def inside_board(row,col)
  (0..2) === row and (0..2) === col
end

#now we'll define how players can move on the board

def valid_move(row, col)
  is_empty(row, col) and inside_board(row,col)
end

def dropPiece(piece, row, col)
  @board[row][col] = piece if valid_move(row,col)
end
end

#this method will clear the board
def clear_screen
  puts "\n" * 100
end

#now we prompt the next player to make a move, take the input, and place it on the board accordingly
def prompt_move(active_player)
  puts "#{active_player}'s turn. Choose a box.",
  "            **~V~**"
  print "          "
#here we convert the string input to an integer and place it on the grid
  move = gets.chomp.to_i - 1
  row = move/3
  col = move %3
  return row,col
end

#next we will define a method of notifying the winner that they've won
#or letting the players know that its a tie
#then we'll clear the screen for the next round

def alert_winner(winner,board)
  puts "     --**~^^^^^^^~**--"

  if winner == "C"
    puts " Cat's Game!"
  else 
    puts " #{winner} ' s win"
  end

  
  puts "  ----**~vVv**----"
  puts "\n"
  board.printboard
  puts "\n         **~V~**"
end

#here were defining a method of starting a game of tic tac toe and determining which part of the grid has what on it
#this way, you can't put two x's or two o's on the same part of the board
def tictactoe(boardclass)
  board = boardClass.new
  active_player = 'X'

  clear_screen
  board.printinstructions

while not board.findWinner

    row,col = prompt_move(active_player)
    clear_screen


    if board.dropPiece(active_player, row, col)
      if active_player == "X"
        active_player = "O"
      else active_player = "X"
      end
    else
      puts "  invalid move, please try another square\n\n"
    end

    board.printboard
  end

winner = board.findWinner
clear_screen

alert_winner(winner,board)
end

#now that a winner has been delcared we will prompt the players to see if they want to play another round
#if they dont want to play another game we put goodbye
while true
  clear_screen
  puts "Do you want to play another game? (y/n)"
  if ['no,' 'n'].include? (gets.chomp.downcase)
puts "goodbye"
break
end
tictactoe(Board)
end



