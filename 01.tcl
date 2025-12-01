#!/usr/bin/env tclsh
proc aoc_01 { } {
    set d [split [aoc_read "01.data"] "\n"]
    set res {}
    
    set dial  50
    set count1 0
    set count2 0
    foreach line $d {
        set dial_old $dial
        set dir [string range $line 0 0]
        set num [string range $line 1 end]

        set pass [expr {int($num/100)}]
        set num  [expr {$num % 100}]
        
        switch $dir {
            L {
                if {$num > $dial && $dial != 0} {
                    incr pass 1
                }
                set dial [expr { ($dial - $num) % 100 }]
            }
            R {
                if {$num > (100-$dial)} {
                    incr pass 1
                }
                set dial [expr { ($dial + $num) % 100 }]
            }
        }
        
        if {$dial == 0} {
            incr count1
            incr pass
        }
        if {$pass} {
            incr count2 $pass
        }
        # puts "From $dial_old the dial is rotated ($dir)($num) to point at [expr $dial % 100] $pass."
    }
    lappend res $count1 $count2


    


    
    return $res
}



if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_01]
}
