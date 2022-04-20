set fd [open {./lab1_material/CORE65LPSVT_bc_1.30V_m40C.lib} {r}]

set cell_ref_list {"HS65_LS_IVX2" "HS65_LS_NAND2X2" "HS65_LS_NOR3X2"}

;# Elements needed to manage ParserFSM
set state "CELL"
set continue_flag [gets $fd line]
set next 0
set pin_cap_list [list]
set cap_list [list]

while { $continue_flag >= 0 } {

  if { $state eq "CELL" } {
    set next 1
    ;# Match a cell(HS...) line and extracts name_cell
    set res [regexp {\s*cell\(([A-Z0-9_]+)\)} $line matchVar name_cell]
    if { $res == 1} {
      if { [lsearch $cell_ref_list $name_cell ] > -1 } {
        puts "Found the cell with name: $name_cell"
        set state "PIN"
      }
    }
  } elseif { $state eq "PIN" } {
    ;# 2 Possible actions:
    ;#   * match a cell line        -> do not go to next line -> change state
    ;#   * do not match a cell line -> go to next line        -> look for pin
    ;#

    ;# Match a cell line -> this means that we are into a new cell section
    set res [regexp {\s*cell\(([A-Z0-9_]+)\)} $line matchVar name_cell]
    if { $res == 1 } {
      set state "CELL"
    } else {
      set next 1
      ;# Match a pin line
      set res [regexp {\s*pin\(([A-Z0-9_]+)\)} $line matchVar pin_name]
      if { $res == 1} {
        puts "Found a pin with name: $pin_name"
	set state "insidePIN"
      }
    }
  } elseif { $state eq "insidePIN"} {
        set next 1
	regexp {\s*capacitance\s\:\s(0(\.)?[0-9]+)} $line matchVar cap_val
	set res [regexp {\s*direction\s\:\s([a-zA-Z]+)} $line matchVar direction]
	if { $res == 1} {
	   if { $direction eq "output" } {
	      	set state "CELL"
		set pin_cap_list [lappend pin_cap_list $cap_list]
		set cap_list [list]
	   } else {
	      	set cap_list [lappend cap_list $cap_val]
		puts "capacitance: $cap_val added to the list"	
	   }	
        }	
  }

  ;# Only if the current line has been processed then load a new line
  if { $next == 1 } {
    set continue_flag [gets $fd line]
    set next 0
  }
}
close $fd

puts "\npin_cap_list content:"
foreach el $pin_cap_list {
   puts $el
}
