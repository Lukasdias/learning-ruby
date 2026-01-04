require "colorized_string"
require "tty-reader"
require "tty-cursor"
require_relative "ui_helper"

# Takes care of rendering messages, menu templates etc
# Render all elements in terminal
class GameRenderer
  include UIHelper

  def initialize(game)
    @game = game
    @reader = TTY::Reader.new
    @cursor = TTY::Cursor
  end

  def show_menu
    clear_screen
    show_header("Tic Tac Toe Main Menu")
    show_divider
    puts "\n1. Play\n2. Quit\n"
    print "Choose: "
  end

  def setup_players
    clear_screen
    show_header("Player Setup")
    show_divider

    player1_name, player1_symbol = get_player_input(1)
    player2_symbol = player1_symbol == "X" ? "O" : "X"
    player2_name = get_player_2_input(player2_symbol)

    player1 = Player.new(player1_name, player1_symbol)
    player2 = Player.new(player2_name, player2_symbol)

    @game.set_players(player1, player2)
  end

  def show_table
    clear_screen
    show_header("Tic Tac Toe Game")
    show_divider
    render_board
  end

  def get_move(player)
    clear_screen
    show_header("Tic Tac Toe Game")
    show_divider
    puts ColorizedString["\n#{player.name}'s turn (#{player.symbol})"].colorize(:green)

    cursor_row = 0
    cursor_col = 0

    render_table_with_cursor(cursor_row, cursor_col)

    loop do
      key = @reader.read_keypress

      case key
      when "\e[A"  # up arrow
        cursor_row = (cursor_row - 1) % 3
        render_table_with_cursor(cursor_row, cursor_col)
      when "\e[B"  # down arrow
        cursor_row = (cursor_row + 1) % 3
        render_table_with_cursor(cursor_row, cursor_col)
      when "\e[D"  # left arrow
        cursor_col = (cursor_col - 1) % 3
        render_table_with_cursor(cursor_row, cursor_col)
      when "\e[C"  # right arrow
        cursor_col = (cursor_col + 1) % 3
        render_table_with_cursor(cursor_row, cursor_col)
      when "\r"    # enter
        return [cursor_row, cursor_col] if @game.do_move(cursor_row, cursor_col, player.symbol)

        show_message("Invalid move! Position taken.")
        sleep 1
        render_table_with_cursor(cursor_row, cursor_col)
      end
    end
  end

  def show_game_end(result_message)
    clear_screen
    show_header("Tic Tac Toe Game - Final Result")
    show_divider
    render_board
    puts ColorizedString[result_message].colorize(:bold)
    puts "\nPress ENTER to return to menu..."
    gets
  end

  private

  def render_board
    puts "\n"
    @game.table.each_with_index do |row, idx|
      colored_row = row.map { |cell| colorize_cell(cell) }.join(" | ")
      puts colored_row
    end
    puts "\n"
  end

  def render_table_with_cursor(cursor_row, cursor_col)
    puts "\n"
    @game.table.each_with_index do |row, row_idx|
      row_str = ""
      row.each_with_index do |cell, col_idx|
        is_cursor = row_idx == cursor_row && col_idx == cursor_col
        cell_display = colorize_cell(cell)

        row_str += if is_cursor
                     ColorizedString["[#{cell_display}]"].colorize(background: :white)
                   else
                     " #{cell_display} "
                   end

        row_str += " | " unless col_idx == 2
      end
      puts row_str
    end
    puts "\nUse arrow keys to move, ENTER to place\n"
  end

  def get_player_input(player_num)
    loop do
      print "Enter Player #{player_num} name: "
      name = gets.chomp
      next if name.empty?

      print "Enter Player #{player_num} symbol (X or O): "
      symbol = gets.chomp.upcase

      return [name, symbol] if %w[X O].include?(symbol)

      puts "Invalid symbol! Use X or O."
    end
  end

  def get_player_2_input(symbol)
    print "Enter Player 2 name: "
    name = gets.chomp
    show_message("\nPlayer 2 will use symbol: #{symbol}\n")
    name
  end
end
