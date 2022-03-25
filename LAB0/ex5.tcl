set paragraph  {Write a Tcl script that declares a variable called paragraph which contains the assignment of this exercise (or any other arbitrary text). The script should be able to:
1. Report the word count of the text contained in paragraph (consider the split function)
2. Create a new variable where the original text is modified as to include the word "program" instead of the word "script"; then, print the obtained result to the terminal (refer to the functions replace or lreplace).}


set myList [split $paragraph " "]

puts "THIS IS MY TEXT:"
puts $paragraph

puts "Word count: $lun"
set indexes [list]
set indexes [lsearch -all $myList "script"]
foreach i $indexes {
   set myList [lreplace $myList $i $i "program"]
}
set myNewList [join $myList]
puts "THIS IS MY NEW TEXT"
puts $myNewList
