require_relative "player"

# Core logic of the game - handles state and rules only
class Game
  EMPTY = "-"
  attr_accessor :table, :player1, :player2, :current_player

  def initialize
    @table = Array.new(3) { Array.new(3, EMPTY) }
    @player1 = nil
    @player2 = nil
    @current_player = nil
  end

  def reset_game
    @table = Array.new(3) { Array.new(3, EMPTY) }
  end

  def do_move(row, col, symbol)
    return false unless valid_move?(row, col)

    @table[row][col] = symbol
    true
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def set_players(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def winner?
    check_rows || check_columns || check_diagonals
  end

  def draw?
    @table.flatten.none? { |cell| cell == EMPTY }
  end

  private

  def valid_move?(row, col)
    row.between?(0, 2) && col.between?(0, 2) && @table[row][col] == EMPTY
  end

  def check_rows
    @table.each do |row|
      return true if row.uniq.length == 1 && row[0] != EMPTY
    end
    false
  end

  def check_columns
    (0..2).each do |col|
      column = [@table[0][col], @table[1][col], @table[2][col]]
      return true if column.uniq.length == 1 && column[0] != EMPTY
    end
    false
  end

  def check_diagonals
    # main diagonal (top-left to bottom-right)
    main_diagonal = [@table[0][0], @table[1][1], @table[2][2]]
    return true if main_diagonal.uniq.length == 1 && main_diagonal[0] != EMPTY

    # anti-diagonal (top-right to bottom-left)
    anti_diagonal = [@table[0][2], @table[1][1], @table[2][0]]
    return true if anti_diagonal.uniq.length == 1 && anti_diagonal[0] != EMPTY

    false
  end
end
