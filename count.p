def var i as int.
for each {1} no-lock. i = i + 1. end.
output to reccount.txt append.
put unformatted "{1} " i skip.
output close.
