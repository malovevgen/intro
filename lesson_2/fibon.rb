fibon = [0, 1]
numnext = 1
last_num = 100
loop do
  fibon.push(numnext)
  numnext = fibon[-1] + fibon[-2]
  break if numnext >= last_num
end
fibon.each { |value| puts value }
