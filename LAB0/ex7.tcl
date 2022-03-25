set myList [list "file_record.pdf" "doc_0724199.pdf" "file_test.jpg" "file_template.pdf.tmp"]
puts "My list is:"
foreach s $myList {
   puts $s
}

set i 0
set myNewList [list]
foreach s $myList {
   set res [regexp {.*pdf$} $s ]
   if { $res } {
   	set last [string length $s]
   	incr last -1
   	set first [expr {$last - 3}]
   	set new [string replace $s $first $last ""]
   	set myNewList [lappend myNewList $new]
   }
   incr i
}
puts "\nmy new list is:"
foreach s $myNewList {
   puts $s
} 
