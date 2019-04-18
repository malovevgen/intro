puts "Вид квадратного уравнения:"
puts "ах^2 + bx + c = 0"
puts "Введите коэффициент a"
a = gets.chomp.to_f

puts "Введите коэффициент b"
b = gets.chomp.to_f

puts "Введите коэффициент c"
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d < 0
	puts "корни мнимые, D = #{d}"
elsif d == 0
  x = (- b/(2 * a))
	puts "корень х = #{x}"
else
  sqrtd = Math.sqrt(d)
  x1 = (- b - sqrtd)/(2 * a)
	x2 = (- b + sqrtd)/(2 * a)
	puts "корни х1 = #{x1} х2 = #{x2}"
end
