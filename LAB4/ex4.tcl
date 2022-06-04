proc ex4_proc {} {
    set file_name "./saved/aes_cipher_top/post_synthesis_sim/aes_cipher_top_swa.txt"
    set fp [open $file_name "r"]
    set path "/test/u0/"
    puts "Path specified: $path"

    gets $fp line
    gets $fp line

    gets $fp line ;# period
    set total_sim $line
    gets $fp line
    gets $fp line
    gets $fp line
    puts "Net \t\tStat_Prob\tTC\tTotSimPeriod"
    while {[gets $fp line] >=0 } {
        regexp {\s+(.+\s?.+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)} $line match net toggle_count toggle_i time_at_one time_at_zero time_x 
        regsub {/test/u0/} $net "" Net
        regsub {\(} $Net "\[" Net
        regsub {\)} $Net "\]" Net
        regsub {\\} $Net "" Net
        regsub {\s} $Net "" Net
        set static_probability [expr double($time_at_one)/$total_sim]
        puts "$Net \t $static_probability \t\t $toggle_count \t $total_sim" 
        set_switching_activity $Net -static_probability $static_probability -toggle_rate $toggle_count -period $total_sim 
    }
    close $fp
    return
}