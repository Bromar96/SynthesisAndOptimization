set var_reference 10 ;# is another parameter for the procedure

proc my_proc {par1 par2} {
    global var_reference
    set product [expr $par1 * $par2]
    if {$product == $var_reference} {
        return 1
    } else {
        return 0
    }
}

#remember to source this script before using the procedure on tclsh