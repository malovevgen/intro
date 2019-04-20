number_days_months = {
  January: 31,
  Febraury: 28, 
  March: 31, 
  April: 30,
  May: 31,
  Juny: 30,
  Yuly: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31}

  number_days_months.each do |month, days|
    puts month if days == 30
end
