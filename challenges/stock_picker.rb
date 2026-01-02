def stock_picker(prices)
  best_days = []
  max_profit = nil
  prices.each.with_index do |b, b_idx|
    prices.each.with_index(b_idx + 1) do |s, s_idx|
      buy = prices[b_idx]
      sell = prices[s_idx]
      break if buy.nil? or sell.nil?
      profit = sell - buy
      if max_profit.nil? or profit > max_profit 
        max_profit = profit
        best_days = [b_idx, s_idx]
      end
    end
  end
  best_days
end

puts stock_picker([17,3,6,9,15,8,6,1,10])