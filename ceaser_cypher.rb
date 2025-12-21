$alphabet = ('a'..'z').to_a

def caesar_cipher(text, num)
  # to implement
end

print "Write the text to be encoded: "
phrase = gets.chomp()

print "Write the shift factor: "
shift_factor = gets.chomp()

puts caesar_cipher(phrase, shift_factor)