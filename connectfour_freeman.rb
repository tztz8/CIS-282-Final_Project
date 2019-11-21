############################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Connect Four - Final Project
#  Date:        11/13/2019
#  Class:       CIS 282
#  Description: Connect Four game using ruby and terminal
#
############################################################

# variables
$column_size = 8
$player1_game_piece = 'x'
$player2_game_piece = 'O'
$size_to_win = 4
# print screen
def print_screen(board)
  puts ""
  for i in 1..$column_size
    print "#{i} "
  end
  puts ""
  for i in 0...$column_size
    for j in 0...$column_size
      print "#{board[i][j]} "
    end
    puts ""
  end
end
# making the game board
game_board = Array.new($column_size) {Array.new($column_size, '.')}
# run the game
run_program = true
super_i = 0
while run_program
  #get the user's selection
  # check if the user input works //this will let me put in a check if the column is full
  user_input_works = false
  while !user_input_works
    # print the game board
    print_screen(game_board)
    # prompt the user for their turn
    print "Select a column to place your piece (#{$player1_game_piece}): "
    player1_column = gets.chomp.to_i
    if player1_column <= $column_size
      if game_board[0][player1_column-1] != '.'
        puts "Column #{player1_column} is full"
      else
        user_input_works = true
      end
    else
      puts "you must pick a column that exists"
    end
  end
  # place the piece in the double array
  insert_complete = false
  for i in 1..$column_size
    if (game_board[$column_size-i][player1_column-1] == '.' && !insert_complete)
      game_board[$column_size-i][player1_column-1] = $player1_game_piece
      insert_complete = true
    end
  end
  # reprint the screen
  print_screen(game_board)
  # check to see if the user won
  for i in 0...$column_size
    for j in 0...$column_size
      if (game_board[i][j] != '.')
        game_piece = game_board[i][j]
        win = true
        # # check if 4 in a row right
        # for k in 1...$size_to_win
        #   if game_board[i][j+k] != game_piece
        #     win = false
        #   end
        # end
        # # check if 4 in a row left
        # for k in 1...$size_to_win
        #   if game_board[i][j-k] != game_piece
        #     win = false
        #   end
        # end
        # if (win)
        #   puts "win"
        #   exit
        # end
      end
    end
  end
    # Show the computer's turn
    # get the computer's selection
    # place the piece in the double array
    # reprint the screen
    # check to see if the computer won
  super_i++
  if super_i == 5
    run_program = false
  end
end