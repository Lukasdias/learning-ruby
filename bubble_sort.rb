def bubble_sort(arr)
  arr.each.with_index do |a, i|
    arr.each.with_index(i+1) do |b, j|
      break if arr[j].nil? or arr[i].nil?
      if arr[j] < arr[i] 
        arr[i], arr[j] = arr[j], arr[i]
      end
    end
  end
  arr
end

puts bubble_sort([4,3,78,2,0,2])