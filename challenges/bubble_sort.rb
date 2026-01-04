def bubble_sort(arr)
  arr.each.with_index do |_a, i|
    arr.each.with_index(i + 1) do |_b, j|
      break if arr[j].nil? || arr[i].nil?

      arr[i], arr[j] = arr[j], arr[i] if arr[j] < arr[i]
    end
  end
  arr
end

puts bubble_sort([4, 3, 78, 2, 0, 2])
