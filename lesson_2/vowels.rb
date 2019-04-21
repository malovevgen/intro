alphabet = ("a".."z").zip(1..26).to_h
hash_vowels = {}
string_vowels = "aeiouy"
alphabet.each do |letter, ind|
  hash_vowels[letter] = ind if string_vowels.include? letter
end
hash_vowels.each do |letter, ind|
  puts "#{letter}: #{ind}"
end
