require "colorized_string"

# Helper module for common UI operations
module UIHelper
  def clear_screen
    system("clear") || system("cls")
  end

  def show_header(title)
    puts ColorizedString["╔ #{title} ╗"].colorize(:cyan)
  end

  def show_divider
    puts ColorizedString["─" * 40].colorize(:cyan)
  end

  def show_message(msg)
    puts msg
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
