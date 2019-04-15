=begin Эта программа запрашивает основание и высоту треугольника
и возвращает его площадь
=end


puts "Введите основание треугольника"
basis=gets.chomp.to_f

puts "Введите высоту треугольника"
weight=gets.chomp.to_f

squaretriangl=0.5*basis*weight
puts "Площадь треугольника-#{squaretriangl}"