set cell_list_name [list] 
set cell_list_ref [list]
set cell_list_area [list]
set cell_list_leakage [list]
set cell_list_dynamic [list]
set ordered_collection [sort_collection [get_cells] leakage_power]
foreach_in_collection point_cell $ordered_collection {
   set cell_name [get_attribute $point_cell full_name]
   set cell_type [get_attribute $point_cell is_combinational]
   set cell_ref [get_attribute $point_cell ref_name]
   set cell_area [get_attribute $point_cell area]
   set cell_leakage [get_attribute $point_cell leakage_power]
   set cell_dynamic [get_attribute $point_cell dynamic_power]
   if { $cell_type == true } {
        puts "$cell_name is combinational"
        lappend cell_list_name $cell_name 
        lappend cell_list_ref $cell_ref
        lappend cell_list_area $cell_area
        lappend cell_list_leakage $cell_leakage
        lappend cell_list_dynamic $cell_dynamic
   } else {
        puts "$cell_name is sequential"
   }
}

set chip_area 0
foreach single_area $cell_list_area {
     set chip_area [expr {$single_area + $chip_area}] 
}
puts "Chip area: $chip_area"

set chip_leakage 0
foreach single_leakage $cell_list_leakage {
     set chip_leakage [expr {$single_leakage + $chip_leakage}] 
}
puts "Chip leakage power: $chip_leakage"

set chip_dynamic 0
foreach single_dyn $cell_list_dynamic {
     set chip_dynamic [expr {$single_dyn + $chip_dynamic}] 
}
puts "Chip dynamic power: $chip_dynamic"

#To compare chip area
#report_cell [get_cells -filter "is_combinational == true"]

#To compare chip power
#report_power
#remember that dynamic power = InternalPower + SwitchingPower