# Input an array of numbers representing stock prices on each day
# Output an array of a pair of number representing the best days to buy and sell
# Iterate the array, for each number, calculate the profit for each future sell
# to store and compare to the maximum profit
# Worst case O(n^2)
# 
# Create a hash with keys as days and values as stock prices, sort the hash by
# stock prices
# Worse case O(n^2)
# 
# Initialize a number min that's the smallest number so far in the current iteration
# Initialize a number max = currentnumber - i
# 

def stock_picker(arr)
  
  buy_day = 0
  sell_day = 1
  min = arr[buy_day]
  max = arr[sell_day] - arr[buy_day]
  for i in 1..(arr.length - 1)
    if arr[i] - min > max
      max = arr[i] - min
      sell_day = i
    end
    if arr[i - 1] < min && i - 1 < sell_day
      buy_day = i - 1
      min = arr[buy_day]
    end
  end
  [buy_day, sell_day]

end



test_cases = [
  # Basic case
  { input: [17, 3, 6, 9, 15, 8, 6, 1, 10], expected: [1, 4] },

  # Already sorted ascending
  { input: [1, 2, 3, 4, 5], expected: [0, 4] },

  # Already sorted descending (best we can do is adjacent days)
  { input: [5, 4, 3, 2, 1], expected: [3, 4] },

  # All same price
  { input: [3, 3, 3, 3], expected: [0, 1] },

  # Best buy is not the lowest price overall
  { input: [5, 1, 4, 2, 8], expected: [1, 4] },

  # Must buy before sell (not just min/max)
  { input: [8, 2, 9, 1, 3], expected: [1, 2] },

  # Two day array
  { input: [1, 5], expected: [0, 1] },

  # Profit at the end
  { input: [3, 1, 4, 1, 5, 9], expected: [3, 5] },
]



# Another much cleaner implementation stolen from Claude
# My solution was updating max and min separately so I had to check
#i - 1 < sell_day so the buy_day doesn't get ahead of sell_day
# To solve this, you update both buy_day and sell_day at the same time if
#arr[i] - arr[min_day] yield the most profit so far, then you update sell_day = i
#and buy_day = min_day.
# Update min_day = i if arr[i] < arr[min_day]. You are updating min_day = i
#then in the *next* iteration, if conditions satisfied you update 
#buy_day = min_day, sell_day = 1
# This way, buy_day never gets ahead of sell_day
# Explaination is messy because I don't understand this myself, and I'm trying to
#make things make sense to myself. 

def stock_picker2(arr)
  # Entry to the stock market
  best_buy = 0
  best_sell = 1
  min_day = 0

  (1...arr.length).each do |i|
    if arr[i] - arr[min_day] > arr[best_sell] - arr[best_buy]
      best_sell = i
      best_buy = min_day
    end
    min_day = i if arr[i] < arr[min_day]
  end

  [best_buy, best_sell]
end

test_cases.each_with_index do |item, index|
  result = stock_picker2(item[:input])
  if result == item[:expected]
    puts "##{index + 1} Passed"
  else
    puts "##{index + 1} Failed — expected #{item[:expected]}, got #{result}"
  end
end