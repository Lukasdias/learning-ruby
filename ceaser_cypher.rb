def shift_char(char, shift)
  if char >= 'a' && char <= 'z'
    # convert everyone into num
    # char = 'c' -> char.ord = 99
    # convert interval from ASCII in to 0 - 25
    # a -> 0 ; b -> 1 and so on
    # %26 is to make it circular
    # when shifting beyond the alphabet, the code must reset to the start again
    (((char.ord - 'a'.ord + shift) % 26) + 'a'.ord).chr
  elsif char >= 'A' && char <= 'Z'
    (((char.ord - 'A'.ord + shift) % 26) + 'A'.ord).chr
  else
    char
  end
end


def caesar_cipher(text, shift)
  text.each_char.map { |char| shift_char(char, shift) }.join
end

print "Write the text to be encoded: "
phrase = gets.chomp()

print "Write the shift factor: "
shift = gets.chomp.to_i

puts caesar_cipher(phrase, shift)