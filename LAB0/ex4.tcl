set myList [list "summer" "autumn" "winter" "spring"]
puts "Seasons are:"
foreach season $myList {
   puts $season
}
set pos [lsearch $myList "spring"]
puts "Spring is stored at position $pos"
