alphabet = ("a".."z").zip(1..26).to_h
hash_vowels = {}
string_vowels = "aeiouy"
alphabet.each do |letter, index|
  puts "#{letter}: #{index}" if string_vowels.include? letter
end
