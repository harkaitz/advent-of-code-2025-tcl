#!/usr/bin/env tclsh
proc aoc_09 { } {
    set input [aoc_read "09.data"]
    set tiles [lmap line [split $input "\n"] { split $line "," }]
    puts [part1 $tiles]
    return {}
}
proc part1 { tiles } {
    set f_area 0
    foreach pos1 $tiles {
        lassign $pos1 x1 y1
        foreach pos2 $tiles {
            if {$pos1 eq $pos2} continue
            lassign $pos2 x2 y2
            set area [expr {(abs($x1-$x2)+1)*(abs($y1-$y2)+1)}]
            if {$area > $f_area} {
                set f_area $area
            }
        }
    }
    return $f_area
}
if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_09]
}
