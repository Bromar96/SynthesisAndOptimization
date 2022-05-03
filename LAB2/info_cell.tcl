
foreach_in_collection point_cell [get_cells] {
   set cell_name [get_attribute $point_cell full_name]
   set cell_type [get_attribute $point_cell is_combinational]
   if { $cell_type == true } {
        puts "$cell_name is combinational"
   } else {
        puts "$cell_name is sequential"
   }
}