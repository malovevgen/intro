alphabet = Hash[("а".."я").zip(0..31).to_h]
hash_vovels = {}
string_vovels = "аеиоуыэюя"
alphabet.each do |letter, index|
  hash_vovels[letter] = index if string_vovels.include? letter
  end
   hash_vovels.each do |letter, index|
    puts "#{letter}: #{index}"
  end
