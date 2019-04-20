purchases = {}
sum_of_product = 0
total_sum = 0
loop do
  puts "Введите название товара"
  title = gets.chomp.capitalize
  break if title == "стоп"
  puts "Введите цену товара"
  price = gets.chomp.to_f
  puts "Введите количество купленного товара"
  number = gets.chomp.to_f
  purchases[title] = {price => number}
end
purchases.each do |title, price_and_number|
  price_and_number.each {|price, number| sum_of_product = price * number }
  puts "#{title}: #{sum_of_product}"
  total_sum += sum_of_product
end
puts "ИТОГО: #{total_sum}"
