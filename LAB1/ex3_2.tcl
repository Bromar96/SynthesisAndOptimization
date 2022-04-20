
set fd [open {./lab1_material/CORE65LPSVT_bc_1.30V_m40C.lib} {r}]
set cell_list {"HS65_LS_IVX2" "HS65_LS_NAND2X2" "HS65_LS_NOR3X2"}
set tech_par {"area" "leakage" "fall"}

set state "CELL"
set continue_flag [gets $fd line]
set next 0
set output_list [list]
set cell_pars [list]

while { $continue_flag >= 0 } {
   if { $state eq "CELL" } {
   	set next 1
    	set res [regexp {\s*cell\(([A-Z0-9_]+)\)} $line matchVar name_cell]
    	if { $res == 1} {
      	   if { [lsearch $cell_list $name_cell ] > -1 } {
           	puts "Found the cell with name: $name_cell"
           	set cell_pars [lappend cell_pars $name_cell]
	   	set state "AREA"
       	   }
    	}
   } elseif { $state eq "PIN" } {
   	set next 1
   	set res [regexp {\s*pin\(Z\)} $line matchVar pin_name]
    	if { $res == 1 } {
	      set state "FALL"
    	}
  } elseif { $state eq "AREA" } {
     	set next 1
	set res [regexp {\s*area\s\:\s([0-9]*(\.)?[0-9]*)} $line matchVar area]
     	if { $res == 1} {
           set cell_pars [lappend cell_pars $area]
	   puts -nonewline "\tarea: $area"
	   set state "LEAKAGE"
	}
  } elseif { $state eq "LEAKAGE" } {
     	set next 1
     	set res [regexp {\s*cell_leakage_power\s\:\s([0-9]*(\.)?[a-z0-9]*)} $line matchVar cell_leakage]
     	if { $res == 1} {
          set cell_pars [lappend cell_pars $cell_leakage]
	  puts -nonewline " leakage: $cell_leakage"
          set state "PIN"
     	}
  } elseif { $state eq "FALL" } {
     	set next 1
     	set res [regexp {\s*intrinsic_fall\s\:\s([0-9]*\.?[a-z0-9]*)} $line matchVar fall]
     	if { $res == 1} {
	  puts -nonewline " fall: $fall"
          set cell_pars [lappend cell_pars $fall]
          set state "RISE"
	}
  } elseif { $state eq "RISE" } {
     	set next 1
     	set res [regexp {\s*intrinsic_rise\s\:\s([0-9]*\.?[a-z0-9]*)} $line matchVar rise]
     	if { $res == 1} {
 	   puts " rise: $rise"
           set cell_pars [lappend cell_pars $rise]
           set state "CELL"
           set output_list [lappend output_list $cell_pars]
           set cell_pars [list]
   	}
  } 

  ;# Only if the current line has been processed then load a new line
   if { $next == 1 } {
    	set continue_flag [gets $fd line]
   	set next 0
   }
}
close $fd

puts "\noutput_list content:"
foreach el $output_list {
   puts $el
}
