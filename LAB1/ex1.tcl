set myList [list "pit" "spot" "spate" "slap two" "respite" "pt" "Pot" "peat" "part"]
foreach sample $myList {
   set result [regexp {.*p.t.*} $sample match]
   puts -nonewline "\nString: $sample \t-Result: $result"
   if {$result == 1} {
	puts -nonewline "\t-match: $match"
   }
}

puts "\n\n"

set myList [list "can" "man" "fan" "dan" "ran" "pan"]
foreach sample $myList {
   set res [regexp {[cmf]an} $sample match]
   puts -nonewline "\nString: $sample \t-Result: $res"
   if {$res == 1} {  
	puts -nonewline "\t-match: $match"
   }
}

puts "\n\n"

set myList [list "aaaabcc" "aabbbbc" "aacc" "a"]
foreach sample $myList {
   set res [regexp {aa+b*c*} $sample match]
   puts -nonewline "\nString: $sample \t-Result: $res"
   if {$res == 1} {
	puts -nonewline "\t-match: $match"
   }
}

puts "\n\n"

set myList [list "1. abc" "2. abc" "3. abc" "4.abc" " abc" "5 abc"]
foreach sample $myList {
   set res [regexp {[1-3]\.\sabc} $sample match]
   puts -nonewline "\nString: $sample \t-Result: $res"
   if {$res == 1} {
 	puts -nonewline "\t-match: $match"
   }
}
