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

test_cases.each_with_index do |item, index|
  result = stock_picker(item[:input])
  if result == item[:expected]
    puts "##{index + 1} Passed"
  else
    puts "##{index + 1} Failed — expected #{item[:expected]}, got #{result}"
  end
end