fibon = [0, 1]
last_num = 100
while (numnext = fibon[-1] + fibon[-2]) <= last_num do
  fibon.push(numnext)
end
puts fibon
