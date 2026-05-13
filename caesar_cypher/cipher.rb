# input string and a shift number
# shift numberbin range (-25, 25)
# split then map then join
# if character is alphabet then shift
# if shift out of bound wrap around
# 

A_LOWERCASE_ORD = 'a'.ord
Z_LOWERCASE_ORD = 'z'.ord
A_ORD = 'A'.ord
Z_ORD = 'Z'.ord

def caesar_cipher(str, shift)
  
  str.split('').map do |item|
    item = item.ord
    if item >= A_LOWERCASE_ORD && item <= Z_LOWERCASE_ORD
      item = (item + shift - 97) % 26 + 97 
    elsif item >= A_ORD && item <= Z_ORD
      item = (item + shift - 65) % 26 + 65
    end 
    item = item.chr
  end.join('')
  
end

def get_input
  print "Please enter your string: "
  str = gets.chomp
  print "please enter shift number (no larger than 25, no smaller than -25): "
  shift = gets.chomp.to_i
  while shift > 25 || shift < -25
    print "Please enter shift number (no larger than 25, no smaller than -25): "
    shift = gets.chomp.to_i
  end
  [str, shift]
end

puts caesar_cipher('hello', 3)

tests = [
    { input: ["", 5], expected: "" },
    { input: ["ABC", 1], expected: "BCD" },
    { input: ["XYZ", 3], expected: "ABC" },
    { input: ["abc", 2], expected: "cde" },
    { input: ["xyz", 2], expected: "zab" },
    { input: ["Hello, World!", 5], expected: "Mjqqt, Btwqi!" },
    { input: ["What a string!", 5], expected: "Bmfy f xywnsl!" },
    { input: ["Shift0", 0], expected: "Shift0" },
    { input: ["b", -1], expected: "a" },
    { input: ["a", -1], expected: "z" },
    { input: ["A", -1], expected: "Z" },
    { input: ["abc", 26], expected: "abc" },
    { input: ["ABC", 52], expected: "ABC" },
    { input: ["Rotate by 13", 13], expected: "Ebgngr ol 13" },
    { input: ["12345!@#", 7], expected: "12345!@#" }
]

tests.each { |test| 
    result = caesar_cipher(test[:input][0], test[:input][1])
    puts "Original-> #{ test[:input][0] }\nResult->   #{ result }\n#{ result.eql?(test[:expected]) ? "PASSED" : "FAILED" }\n\n"
}
