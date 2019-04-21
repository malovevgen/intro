puts "Введите день"
days = gets.chomp.to_i

puts "Введите номер месяца"
months = gets.chomp.to_i

puts "Введите год"
year = gets.chomp.to_i

number_days_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 0]
number_days_months[1] = 29 if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
number_days = 0 
for i in 0..(months - 1)
  number_days += number_days_months[i-1]
end
puts "Порядковый номер даты: #{number_days + days}"  
