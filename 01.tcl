#!/usr/bin/env tclsh
proc aoc_01 { } {
    set data [aoc_read "01.data"]
    set dial  50
    set count1 0
    set count2 0
    foreach line [split $data "\n"] {
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
    }
    return [list $count1 $count2]    
}
if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_01]
}
