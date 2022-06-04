proc ex2_proc {} {
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
    puts "Net \t\t\t Stat_Prob \t TC \t TotSimPeriod"
    while {[gets $fp line] >=0 } {
        regexp {\s+(.+\s?.+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)} $line match net toggle_count toggle_i time_at_one time_at_zero time_x 
            #regexp {(.+)\(([0-9]*)\)} $net match key num 
            #set net "key\[$num\]"
        regsub {/test/u0/} $net "" Net
        set static_probability [expr double($time_at_one)/$total_sim]
        puts "$Net \t\t $static_probability \t $toggle_count \t\t $total_sim" 
    }
    close $fp
    return
}
