proc my_report_timing {} {
	set most_critical_path [get_timing_paths] ;#returns only the most critical path
	set my_points [get_attribute $most_critical_path points] ;#obtain the points composing the path
	set clock_edge [get_attribute $most_critical_path startpoint_clock_open_edge_value]
	puts "clock_edge $clock_edge"
	set clock_latency [get_attribute $most_critical_path startpoint_clock_latency]
	puts "clock_latency $clock_latency"
	set offset [expr $clock_edge+$clock_latency]
	set previous_arrival $offset
	#list all the timing points 
	foreach_in_collection point $my_points {
		set point_object [get_attribute $point object]
		set point_name [get_attribute $point_object full_name]
		set arrival [get_attribute $point arrival]
		set arrival [expr $arrival+$offset]
		set incremental [expr $arrival -$previous_arrival]
		set previous_arrival $arrival
		puts "Point name\tArrival time\tIncremental"
    	puts "$point_name\t$arrival\t$incremental"
	}
}