require "colorized_string"
require "tty-reader"
require "tty-cursor"

# Takes care of rendering messages, menu templates etc
# Render all elements in terminal
class GameRenderer
  def initialize(game)
    @game = game
    @reader = TTY::Reader.new
    @cursor = TTY::Cursor
  end

  def show_menu
    puts ColorizedString["\n=== Tic Tac Toe ==="].colorize(:blue)
    puts "1. Play"
    puts "2. Quit"
    print "Choose: "
  end

  def setup_players
    puts ColorizedString["\n--- Player Setup ---"].colorize(:blue)

    player1_name, player1_symbol = get_player_input(1)
    player2_symbol = player1_symbol == "X" ? "O" : "X"
    player2_name = get_player_2_input(player2_symbol)

    player1 = Player.new(player1_name, player1_symbol)
    player2 = Player.new(player2_name, player2_symbol)

    @game.set_players(player1, player2)
  end

  def show_table
    puts "\n"
    @game.table.each_with_index do |row, idx|
      colored_row = row.map { |cell| colorize_cell(cell) }.join(" | ")
      puts colored_row
      puts "----------" unless idx == 2
    end
    puts "\n"
  end

  def get_move(player)
    puts ColorizedString["#{player.name}'s turn (#{player.symbol})"].colorize(:green)

    cursor_row = 0
    cursor_col = 0

    loop do
      render_table_with_cursor(cursor_row, cursor_col)

      key = @reader.read_keypress

      case key
      when :up
        cursor_row = (cursor_row - 1) % 3
      when :down
        cursor_row = (cursor_row + 1) % 3
      when :left
        cursor_col = (cursor_col - 1) % 3
      when :right
        cursor_col = (cursor_col + 1) % 3
      when :return
        return [cursor_row, cursor_col] if @game.do_move(cursor_row, cursor_col, player.symbol)

        show_message("Invalid move! Position taken.")
        sleep 1

      end
    end
  end

  def show_message(msg)
    puts msg
  end

  private

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
      puts "----------" unless row_idx == 2
    end
    puts "\nUse arrow keys to move, ENTER to place"
    puts "\n"
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
    show_message("Player 2 will use symbol: #{symbol}")
    name
  end

  def colorize_cell(cell)
    case cell
    when "X"
      ColorizedString[" #{cell} "].colorize(:red)
    when "O"
      ColorizedString[" #{cell} "].colorize(:yellow)
    else
      "   "
    end
  end
end
