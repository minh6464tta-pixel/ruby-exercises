# Implement a method #substrings that takes a word as the first argument and then
# an array of valid substrings (your dictionary) as the second argument. It 
# should return a hash listing each substring (case insensitive) that was found
# in the original string and how many times it was found.

# First figure out how a word is another word's substring
# Step 1: Slide the substring along the parent string, break upon reaching the end of
# string => No. Break when remaining characters are fewer than substring length
# Find and match the first letter of the substring to the parent's string letter
# When match found, compare the next letter by moving both i and j forward
# if at anypoint string[i] and substring[j] become mismatched break the loop
# ReStart at Step 1
# 

def substring(string, substring)
  j = 0 # substring iterator
  processed_string = string.downcase
  processed_substring = substring.downcase
  is_substring = false
  substring_count = 0
  (processed_string.length - processed_substring.length + 1).times do |i|
    while processed_string[i] == processed_substring[j] && processed_substring[j]
      i += 1
      j += 1
    end
    if j == processed_substring.length
      is_substring = true
      substring_count += 1
    end
    j = 0
  end
  is_substring ? substring_count : 0
end

def substrings(string, dictionary)
  dictionary.reduce(Hash.new(0)) do |accumulator, current_value|
    result = substring(string, current_value)
    accumulator[current_value] += result unless result == 0
    accumulator
  end
end

test_cases = [
  # Basic cases
  { input: ["hello world", ["hello", "world", "ello"]], expected: { "hello" => 1, "world" => 1, "ello" => 1 } },
  { input: ["abcabc", ["abc", "bc"]], expected: { "abc" => 2, "bc" => 2 } },

  # Not found
  { input: ["hello", ["xyz", "zzz"]], expected: {} },

  # Multiple occurrences
  { input: ["aaaa", ["aa", "a"]], expected: { "aa" => 3, "a" => 4 } },

  # Case sensitivity
  { input: ["Hello", ["hello", "Hello"]], expected: {"hello" => 1, "Hello" => 1} },

  # Substring same length as string
  { input: ["abc", ["abc", "abcd"]], expected: { "abc" => 1 } },

  # Empty substring array
  { input: ["hello", []], expected: {} },

  # Single character
  { input: ["hello", ["h", "l", "z"]], expected: { "h" => 1, "l" => 2 } },

  # Overlapping substrings
  { input: ["aaa", ["aa"]], expected: { "aa" => 2 } },

  # Spaces
  { input: ["hello world", ["hello world", "lo wo"]], expected: { "hello world" => 1, "lo wo" => 1 } },
]

test_cases.each_with_index do |item, index|
  string = item[:input][0]
  dictionary = item[:input][1]
  expected = item[:expected]
  result = substrings(string, dictionary)
  if result == expected
    puts "##{index + 1} Passed"
  else
    puts "##{index + 1} Failed. Expected: #{expected}. Got: #{result}"
  end
  
end