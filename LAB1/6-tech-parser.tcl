;###############################################################################
;#                  SIMPLE SKELETON LIBERTY PARSER LAB1
;#
;#  This is only ONE POSSIBLE (partial) solution, it is not the only one.
;#  You can
;#    * use it as reference
;#    * improve it
;#
;###############################################################################

;# Set the path to the liberty file in your workspace
set fd [open {./lab1_material/CORE65LPSVT_bc_1.30V_m40C.lib} {r}]

;# Input parameters
set cell_ref_list {HS65_LS_NAND3X2 HS65_LS_IVX2 HS65_LS_AOI211X13 HS65_LSS_XOR2X12}

;# Elements needed to manage ParserFSM
set state "CELL"
set continue_flag [gets $fd line]
set next 0

while { $continue_flag >= 0 } {

  if { $state eq "CELL" } {
    set next 1
    ;# Match a cell(HS...) line and extracts name_cell
    set res [regexp {\s*cell\(([A-Z0-9_]+)\)} $line matchVar name_cell]
    if { $res == 1} {
      ;# If it's an interesting cell then look for pins
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
      }
    }
  }

  ;# Only if the current line has been processed then load a new line
  if { $next == 1 } {
    set continue_flag [gets $fd line]
    set next 0
  }

}

exit
