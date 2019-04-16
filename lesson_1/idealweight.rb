=begin Эта программа спрашивает имя пользователя,
его вес и рост. Если разность между его ростом и весоm
находится в диапазоне idealweight+-maxdeviation  (105...115), то 
пользователь получает сообщение об идеальном весе. В других
случаях сообщение содержит о необходимости коррекции веса.
=end
puts "Как Вас зовут?"
name= gets.chomp.capitalize!
puts "Какой у Вас вес,#{name}?"
weight=gets.chomp.to_f
puts "Какой у Вас рост,#{name}?"
height=gets.chomp.to_f
coef=height-weight
idealweight=110.0
maxdeviation=5.0
if coef>idealweight+maxdeviation
	puts "#{name},Ваш вес недостаточный. Вам надо набрать #{coef-idealweight} килограммов"
elsif coef<idealweight-maxdeviation
	puts "#{name}, у Bаc лишний вес. Вам надо сбросить #{idealweight-coef} килограммов"
else
	puts "#{name},  Bаш вес идеально соответствует росту!)))"
 end
