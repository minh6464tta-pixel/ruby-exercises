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
  
  result = str.split('').map do |item|
    item = item.ord
    if item >= A_LOWERCASE_ORD && item <= Z_LOWERCASE_ORD
      item += shift
      if item < A_LOWERCASE_ORD
        offset = A_LOWERCASE_ORD - item
        item = Z_LOWERCASE_ORD + 1 - offset
      elsif item > Z_LOWERCASE_ORD
        offset = item - Z_LOWERCASE_ORD
        item = A_LOWERCASE_ORD - 1 + offset
      end
    elsif item >= A_ORD && item <= Z_ORD
      item += shift
      if item < A_ORD
        offset = A_ORD - item
        item = Z_ORD + 1 - offset
      elsif item > Z_ORD
        offset = item - Z_ORD
        item = A_ORD - 1 + offset
      end
    end
    
    item = item.chr
  end.join('')
  puts result
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

caesar_cipher(*get_input())

