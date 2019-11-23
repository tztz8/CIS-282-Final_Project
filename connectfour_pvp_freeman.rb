############################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Connect Four - Final Project - EC PvP
#  Date:        11/13/2019
#  Class:       CIS 282
#  Description: Connect Four game using ruby and terminal
#
############################################################

# variables
$column_size = 8
$player1_game_piece = 'x'
$player2_game_piece = 'O'
$default_game_piece = '.'
$size_to_win = 4
$debug = false
# print screen
def print_screen(board)
  puts ""
  # print the top
  for i in 1..$column_size
    print "#{i} "
  end
  puts ""
  # print the game board
  for i in 0...$column_size
    for j in 0...$column_size
      # print each piece
      print "#{board[i][j]} "
    end
    puts ""
  end
end
# check to see if the user won
def check_win(game_board)
  for i in 0...$column_size
    for j in 0...$column_size
      # see if there is a piece
      if (game_board[i][j] != $default_game_piece)
        puts "*DEBUG*--found a piece at [#{i}][#{j}]--" if $debug
        # save the game piece
        game_piece = game_board[i][j]
        puts "*DEBUG*--game_piece=#{game_piece}--" if $debug
        pieces = 1 # count the pieces
        # check if 4 in a row right
        for k in 1...$size_to_win
          if game_board[i][j+k] == game_piece
            pieces = pieces + 1 # count the pieces
          end
        end
        puts "*DEBUG*--pieces=#{pieces}--" if $debug
        # check if 4 in a row down right
        if (pieces != $size_to_win)
          pieces = 1# reset the count for pieces
          if ((i+$size_to_win-1) < $column_size)
            if ((j+$size_to_win-1) < $column_size)
              for k in 1...$size_to_win
                if game_board[i+k][j+k] == game_piece
                  pieces = pieces + 1 # count the pieces
                end
              end
            end
          end
          puts "*DEBUG*--pieces=#{pieces}--" if $debug
        end
        # check if 4 in a row down left
        if (pieces != $size_to_win)
          pieces = 1# reset the count for pieces
          if ((i+$size_to_win-1) < $column_size)
            if ((j-($size_to_win-1)) < $column_size)
              for k in 1...$size_to_win
                if game_board[i+k][j-k] == game_piece
                  pieces = pieces + 1 # count the pieces
                end
              end
            end
          end
          puts "*DEBUG*--pieces=#{pieces}--" if $debug
        end
        # check if 4 in a column
        if (pieces != $size_to_win)
          pieces = 1# reset the count for pieces
          if ((i+($size_to_win-1)) < $column_size)
            for k in 1...$size_to_win
              if game_board[i+k][j] == game_piece
                pieces = pieces + 1 # count the pieces
              end
            end
          end
          puts "*DEBUG*--pieces=#{pieces}--" if $debug
        end
        if (pieces == $size_to_win)
          return game_piece
        end
      end
    end
  end
end
# place piece in game board
def insert_game_piece(game_board, player_column, player_game_piece)
  # place the piece in the double array
  insert_complete = false
  for i in 1..$column_size
    if (game_board[$column_size-i][player_column-1] == $default_game_piece)
      if (!insert_complete)
        game_board[$column_size-i][player_column-1] = player_game_piece
        insert_complete = true
      end
    end
  end
end
# making the game board
game_board = Array.new($column_size) {Array.new($column_size, $default_game_piece)}
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
    print "Player 1 Select a column to place your piece (#{$player1_game_piece}): "
    player1_column = gets.chomp.to_i
    # check if the user select a column
    if player1_column <= $column_size
      # check if the column is full
      if game_board[0][player1_column-1] != $default_game_piece
        puts "Column #{player1_column} is full"
      else
        user_input_works = true
      end
    else
      puts "you must pick a column that exists"
    end
  end
  # place the piece in the double array
  insert_game_piece(game_board, player1_column, $player1_game_piece)
  # reprint the screen
  print_screen(game_board)
  # check if there is a win for player 1
  check_win_output = check_win(game_board)
  puts check_win_output if $debug
  if (check_win_output == $player1_game_piece)
    puts "Player 1 win"
    run_program = false
  else
    # Show the computer's turn
    # get the computer's selection
    user_input_works = false
    while !user_input_works
      # print the game board
      print_screen(game_board)
      # prompt the user for their turn
      print "Player 2 Select a column to place your piece (#{$player2_game_piece}): "
      player2_column = gets.chomp.to_i
      # check if the user select a column
      if player2_column <= $column_size
        # check if the column is full
        if game_board[0][player2_column-1] != $default_game_piece
          puts "Column #{player2_column} is full"
        else
          user_input_works = true
        end
      else
        puts "you must pick a column that exists"
      end
    end
    # place the piece in the double array
    insert_game_piece(game_board, player2_column, $player2_game_piece)
    # reprint the screen
    print_screen(game_board)
    # check to see if the computer won
    check_win_output = check_win(game_board)
    puts check_win_output if $debug
    if (check_win_output == $player2_game_piece)
      puts "Player 2 win"
      run_program = false
    end
  end
  # check if the game board if full to stop the game
  super_i = super_i + 1
  if (super_i == (($column_size*$column_size)/2))
    run_program = false
    print_screen(game_board)
    puts "tie"
  end
end
puts "Thanks for playing"