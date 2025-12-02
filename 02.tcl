#!/usr/bin/env tclsh
proc aoc_02 { } {
    set input [aoc_read "02.data"]
    set part1 0
    set part2 0
    foreach range [split $input ","] {
        lassign [split $range "-"] start end
        for { set id $start } {$id <= $end} { incr id } {
            incr part1 [invalid_id_1 $id]
            incr part2 [invalid_id_2 $id]
        }
    }
    return [list $part1 $part2]
}
proc invalid_id_1 { id } {
    if {[string index $id 0] eq "0"} {
        return [scan $id %d]
    }
    set length [string length $id]
    if {$length % 2} {
        return 0
    }
    set part1 [string range $id                  0 [expr {$length/2 - 1}]]
    set part2 [string range $id [expr {$length/2}]                    end]

    if {$part1 eq $part2} {
        return $id
    }
    return 0
}
proc invalid_id_2 { id } {
    set length [string length $id]
    for { set div 2 } { $div <= $length } { incr div } {
        if {$length % $div} {
            continue
        }
        set piece [string range $id 0 [expr {$length/$div-1}]]
        set candidate [join [lrepeat $div $piece] ""]
        if {$id eq $candidate} {
            return $id
        }
    }
    return 0
}
if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_02]
}
