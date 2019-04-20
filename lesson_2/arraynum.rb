arraynum = []
num = 10
step = 5
last_num = 100
loop do
 arraynum.push (num)
 num += step
 break if num > last_num
end
arraynum.each {| value | puts value }
