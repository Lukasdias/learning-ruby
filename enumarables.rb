my_array = [1, 2]

my_array.each do |num|
  num *= 2
  puts "The new number is #{num}."
end

#=> The new number is 2.
#=> The new number is 4.

#=> [1, 2]
#

my_hash = { "one" => 1, "two" => 2 }

my_hash.each { |key, value| puts "#{key} is #{value}" }

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

puts friends.map {|friend| friend.upcase}


my_order = ['medium Big Mac', 'medium fries', 'medium milkshake']

puts my_order.map { |item| item.gsub('medium', 'extra large') }
#=> ["extra large Big Mac", "extra large fries", "extra large milkshake"]


















my_numbers = [5, 6, 7, 8]
sum = 0

my_numbers.each { |number| sum += number }

puts `sum`, sum
#=> 26
