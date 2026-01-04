require "colorized_string"
require_relative "player"

# Core logic of the game
class Game
  attr_accessor :table, :player1, :player2

  def initialize
    @table = Array.new(3) { Array.new(3, "-1") }
  end

  def start
    puts "start"
  end

  def reset_game
    self.table = Array.new(3) { Array.new(3, "-1") }
  end

  def apply_turn(pos, symbol)
  end

  def print_cell_item(cell)
    ColorizedString["#{cell} "].colorize(cell == "X" ? :red : :yellow)
  end

  def render_table
    puts
    table.each do |row|
      puts row
        .map { |cell| print_cell_item(cell) }
        .join
    end
  end

  def do_move(move, player)
    # check if move is possible
    # check if player is ok
    # check if move trigger win(full col, full row or full diagonal )
    # just return something ifs good
  end

  def create_players
    # render some fancy ui using colorize

    puts ColorizedString["--- Tic Tac Toe Player Creation ---"].colorize(:blue)
    player1_username = ""
    player1_symbol = ""
    player2_username = ""
    player2_symbol = ""

    loop do
      puts
      print "Enter username for player 1: "
      player1_username = gets.chomp
      if player1_username.nil?
        puts("Invalid username")
        redo
      end
      print "Enter the player 1 symbol(X or O): "
      player1_symbol = gets.chomp.upcase
      if player1_symbol != "X" && player1_symbol != "O"
        puts("Invalid symbol, please use either X or O")
        redo
      end
      break
    end

    loop do
      puts
      print "Enter username for player 2: "
      player2_username = gets.chomp
      if player2_username.nil?
        print("Invalid username")
        redo
      end
      player2_symbol = player1_symbol == "X" ? "O" : "X"
      print "Player 1 selected #{player1_symbol}, in this case, your symbol will be #{player2_symbol}"
      break
    end

    self.player1 = Player.new(player1_username, player1_symbol)
    self.player2 = Player.new(player2_username, player2_symbol)
  end

  def render_main
    loop do
      create_players

      render_table
      break
    end
  end
end
