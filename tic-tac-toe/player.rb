# Basic Entity of the tic-tac-toe
# It stores his name
class Player
  attr_reader :name, :picked_symbol

  def initialize(name, picked_symbol)
    @name = name
    @picked_symbol = picked_symbol
  end

  def play(game)
    # do something
  end
end
