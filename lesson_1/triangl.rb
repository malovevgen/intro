=begin Эта программа запрашивает основание и высоту треугольника
и возвращает его площадь
=end


puts "Введите основание треугольника"
basis = gets.chomp.to_f

puts "Введите высоту треугольника"
height = gets.chomp.to_f

squaretriangl = 0.5 * basis * height
puts "Площадь треугольника-#{squaretriangl}"
