set myList [list "file_record.pdf" "doc_0724199.pdf" "file_test.jpg" "file_template.pdf.tmp"]
set myNewList [list]
foreach el $myList {
   puts -nonewline "\nString $el"
   set result [regsub {(\.pdf)$} $el "" new]
   puts "   -result: $result   -match: $new "
   if {$result == 1} {
	set myNewList [lappend myNewList $new]
   }
}

puts "\nMy new list is:"
foreach el $myNewList {
   puts $el
}
