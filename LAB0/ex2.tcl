set a 4
set b 3
set c -1
set d [expr {($b)**2-4*($a)*($c)}]
puts "delta is: $d"
if {$d > 0} {
   set x1 [expr {(-($b)+sqrt($d))/(2*($a))}]
   puts "   x1 value is: $x1"
   set x2 [expr {(-($b)-sqrt($d))/(2*($a))}]
   puts "   X2 value is: $x2"
} else {
   puts "   equation hasn't real solutions"
}
