# Basic Entity of the tic-tac-toe
# Stores player name and symbol
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end
