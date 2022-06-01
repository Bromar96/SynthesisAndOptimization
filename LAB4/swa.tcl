#In the report we have /test/u0/key(127)
#first remove /test/u0
#second replace () with [] (if needed)
set net_name "key[127]"   

#you can verify the presence of the net with the command { get_nets "key[127]" }

set tsim 5000
set toggle_count 3 ;#different for each net
set time_one 50 ;#different for each net
set static_probability [expr double($time_one)/$tsim]  ;#for division remember to cast at least one variable to double

#Toggle rate = Toggle count / simulation_time
#
set_switching_activity $net_name -toggle_rate $toggle_count -period $tsim -static_probability $static_probability


#############
###Open aes_cipher_top_swa.txt
#set file_name "./saved/aes_cipher_top/post_synthesis_sim/aes_cipher_top_swa.txt"
#set fp [open $file_name "r"]
 
####discard 1 and 2 line
#gets $fp line
#gets $fp line
###keep the 3 line -> total simulation time
#gets $fp line 
#set simulation_time $line
#puts "Simulation time: $simulation_time"

###discard lines 4-5-6 
#gets $fp line
#gets $fp line
#gets $fp line

####Read the file line by line and extract the SWA attributes
#gets $fp line
####parse the line with split
### \s+ -> at least one space
### () -> the groups
### \S -> any character different from a space
#regexp {\s+(\S+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)} $line match net toggle_count toggle_i time_one time_zero time_x 
#puts "$net $toggle_count $time_one" 
#set net_static_probability [expr double($time_one) / $simulation_time ]
#puts "$net $toggle_count $net_static_probability" 

#(ex4) Apply the set_switching_activity command

#iterate over all the files -> while 
##At the end
#report_power > ./saved/aes_cipher_top/synthesis/postsyn_powerSWA.rpt