require "colorized_string"
require_relative "ui_helper"
require_relative "game"
require_relative "game_renderer"

include UIHelper

game = Game.new
renderer = GameRenderer.new(game)

loop do
  renderer.show_menu
  choice = gets.chomp

  case choice
  when "1"
    renderer.setup_players

    loop do
      renderer.show_table
      renderer.get_move(game.current_player)

      if game.winner?
        renderer.show_game_end("\n🎉 #{game.current_player.name} wins!")
        break
      end

      if game.draw?
        renderer.show_game_end("\n🤝 It's a draw!")
        break
      end

      game.switch_player
    end
  when "2"
    clear_screen
    puts "Goodbye!"
    break
  else
    show_message("Invalid choice!")
  end
end
