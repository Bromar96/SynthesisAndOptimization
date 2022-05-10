source ./scripts/ex1.tcl

set current_cell_list [list]
set cell_name U14117
set current_cell_list [get_cell_attributes $cell_name]

puts "Attributes\n"
foreach attribute $current_cell_list {
    puts "\t$attribute" 
}
