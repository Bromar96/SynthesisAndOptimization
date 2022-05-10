proc get_cell_attributes {cellName} {
     set flag 0
     set attributes [list]
     set cell [get_cells $cellName]
     set name [get_attribute $cell full_name]
     if {$name eq $cellName} {
          set flag 1
          set name "full_name $name"
          set ref [get_attribute $cell ref_name]
          set ref "reference_name $ref"
          regsub {.+X} $ref "" size
          set size "size $size"
          set area [get_attribute $cell area]
          set area "area $area"
          set lpower [get_attribute $cell leakage_power]
          set dpower [get_attribute $cell dynamic_power]
          set tpower [expr $dpower + $lpower]
          set tpower "total_power $tpower"
          set lpower "leakage_power $lpower"
          set dpower "dynamic_power $dpower"
          set most_critical_path [get_timing_path -through $cell]
          set max_slack [get_attribute $most_critical_path slack]
          set max_slack "max_slack $max_slack"
          #######
          set cell_pins [get_pins -of_object $cell -filter "direction == out"]
          set max_cell_arrival 0
          foreach_in_collection cell_pin $cell_pins {
               set max_fall_arrival [get_attribute $cell_pin max_fall_arrival]
	          set max_rise_arrival [get_attribute $cell_pin max_rise_arrival]
	          #Select the largest value between fall and rise transition
	          set max_pin_arrival [expr max($max_fall_arrival,$max_rise_arrival)]
	          if {$max_pin_arrival > $max_cell_arrival} {
		          set max_cell_arrival $max_pin_arrival
	          } 
          }
          set max_cell_arrival "arrival_time $max_cell_arrival"
          lappend attributes $name
          lappend attributes $ref
          lappend attributes $area
          lappend attributes $size
          lappend attributes $lpower
          lappend attributes $dpower
          lappend attributes $tpower
          lappend attributes $max_cell_arrival
          lappend attributes $max_slack
     }
     if {$flag == 0} {
          puts "\tList is empty, cell doesn't exist"
     }
     return $attributes
}


