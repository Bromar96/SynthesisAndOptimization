set myList [list]
set myList [lappend $myList 0 1 2 3 4 5 6 7 8 9 10]
puts "the content of myList is:"
foreach el $myList {
   puts "$el"
}
set var1 [lindex $myList 5]
set var2 [lindex $myList 10]
set myList [lappend $myList [expr $var1+$var2]]
set last [lindex $myList end]
puts "last item is $last"
