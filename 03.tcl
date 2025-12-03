#!/usr/bin/env tclsh
proc aoc_03 { } {
    set input [aoc_read "03.data"]
    set count1 0
    set count2 0
    foreach bank [split $input "\n"] {
        set bank [split $bank ""]
        incr count1 [batteries $bank 2]
        incr count2 [batteries $bank 12]
    }
    return [list $count1 $count2]
}
proc batteries { bank {number 12} } {
    set result ""
    set left   $bank
    for {set i $number} {$i > 0} {incr i -1} {
        set largest [largest $left [expr {$i-1}]]
        set result  $result[lindex $left $largest]
        set left    [lrange $left [expr {$largest+1}] end]
    }
    return $result
}
proc largest { bank spare } {
    set largest 0
    set result  0
    set length [llength $bank]
    for {set i 0} {$i < ($length-$spare)} {incr i} {
        set joltage [lindex $bank $i]
        if {$joltage > $largest} {
            set largest $joltage
            set result  $i
        }
    }
    return $result
}
if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_03]
}
