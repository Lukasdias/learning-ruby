def factorial(num) 
  _count = num
  start = num - 1
  start.downto(1) { |cur| _count *= cur}
  return _count
end

puts factorial(5)

numbers = Array.new 

numbers.each do |num|
  puts "i like #{num}"
end
