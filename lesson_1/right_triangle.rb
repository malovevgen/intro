puts "Введите длину первой стороны треугольника"
a=gets.chomp.to_f

puts "Введите длину второй стороны треугольника"
b=gets.chomp.to_f

puts "Введите длину третьей стороны треугольника"
c=gets.chomp.to_f

sidearray=[a,b,c]
sidearray.sort!
a=sidearray[0]
b=sidearray[1]
c=sidearray[2]
puts "#{sidearray[0]}"
puts "Треугольник прямоугольный" if c**2==a**2+b**2
print "Треугольник равнобедренный" if (a==b)||(b==c)||(a==c) 
puts " и равносторонний" if (a==b)&&(b==c)&&(a==c)
