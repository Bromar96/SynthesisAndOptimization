proc ex3_proc {} {
    set netlist [get_nets]
    set net_list [list]
    set static_probability_list [list]
    set toggle_count_list [list]
    set cnt 0
    set tsim 5000

foreach_in_collection net $netlist {
    incr cnt
    set name [get_attribute $net full_name]
    set static_probability [get_attribute $net static_probability]
    set static_probability [expr double($static_probability)]
    lappend net_list $name
    lappend static_probability_list $static_probability
    set toggle [get_attribute $net toggle_count]
    lappend toggle_count_list $toggle
}

puts "Net \t StatProb  \t Tc"

for {set i 0} {$i < $cnt} {incr i} {
    set name [lindex $net_list $i]
    set stat [lindex $static_probability_list $i]
    set stat [expr double($stat)]
    set tc [lindex $toggle_count_list $i]
    puts "$name $stat $tc"
}

return 
}