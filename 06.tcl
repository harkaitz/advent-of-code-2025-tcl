#!/usr/bin/env tclsh
proc aoc_06 { } {
    set input [string trim [aoc_read_notrim "06.data"] "\n"]
    return [list [part1 $input] [part2 $input]]
}
proc part1 { input } {
    set count1 0
    foreach line [split $input "\n"] {
        set x 0
        foreach word $line {
            switch $word {
                "*" - "+" { incr count [operation $word {*}$operations($x)] }
                default   { lappend operations($x) $word   }
            }
            incr x
        }
    }
    return $count
}
proc part2 { input } {
    # Get input stats.
    set table [lmap line [split $input "\n"] { split $line "" }]
    set rows  [llength $table]
    set cols  [llength [lindex $table 0]]
    # Allocate new flipped table.
    set ntable [lrepeat $cols [lrepeat $rows " "]]
    # Flip.
    for {set y 0} {$y < $rows} {incr y} {
        for {set x 0} {$x < $cols} {incr x} {
            lset ntable [expr { $cols - $x - 1}] $y [lindex $table $y $x]
        }
    }
    # Perform operations.
    set ninput [join [lmap line $ntable { join $line "" }] "\n"]
    set result 0
    set numbers [list]
    foreach line [split $ninput "\n"] {
        if {[regexp {^ *([0-9][0-9]*) *([\+\*])$} $line ign number operation]} {
            incr result [operation $operation $number {*}$numbers]
            set numbers {}
        } else {
            lappend numbers {*}$line
        }
    }
    return $result
}
proc operation { cmd args } {
    switch $cmd {
        "*" {
            set r 1
            foreach arg $args {
                set r [expr {$r * $arg}]
            }
        }
        "+" {
            set r 0
            foreach arg $args {
                set r [expr {$r + $arg}]
            }
        }
    }
    return $r
}
if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_06]
}
