dictionary = %w[below down go going horn how howdy it i low own part partner sit]

def substrings(phrase, dictionary)
  count = Hash.new(0)
  phrase_clean = phrase.downcase
  for item in phrase_clean.split
    dictionary.select do |w|
      count[w.to_sym] += 1 if item.include?(w)
    end
  end
  count
end

puts substrings('below', dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
