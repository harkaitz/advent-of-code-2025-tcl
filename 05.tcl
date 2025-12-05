#!/usr/bin/env tclsh
proc aoc_05 { } {
    global FRESH_IDS AVAILABLE_IDS
    set input [aoc_read "05.data"]
    parse $input
    simplify
    set count1 0
    set count2 0
    foreach id $AVAILABLE_IDS {
        incr count1 [expr { [get_range $id] ne "" ? 1 : 0 }]
    }
    foreach range [array names FRESH_IDS] {
        incr count2 [expr { 1 + [lindex $range 1] - [lindex $range 0] }]
    }
    return [list $count1 $count2]
}
proc parse { input } {
    global FRESH_IDS AVAILABLE_IDS
    foreach id [split $input "\n"] {
        switch -glob $id {
            {}    { }
            {*-*} { set FRESH_IDS([split $id "-"]) 1 }
            {*}   { lappend AVAILABLE_IDS $id }
        }
    }
}
proc get_range { id {skip ""} } {
    global FRESH_IDS
    foreach range [array names FRESH_IDS] {
        if {$range ne $skip} {
            lassign $range a b
            if {$id >= $a && $id <= $b} {
                return $range
            }
        }
    }
    return ""
}
proc simplify { } {
    global FRESH_IDS
    set changes 1
    while {$changes} {
        set changes 0
        foreach range [array names FRESH_IDS] {
            lassign $range a b
            if {![catch {
                unset FRESH_IDS($range)
            }]} {
                set a_range [get_range $a $range]
                set b_range [get_range $b $range]
                # Inside a range.
                if { ( $a_range ne "" ) && ( $a_range eq $b_range ) } {
                    set changes 1
                    continue
                }
                # Left to a range.
                if {$a_range ne ""} {
                    set a [lindex $a_range 0]
                    set range [list $a $b]
                    unset FRESH_IDS($a_range)
                    set changes 1
                }
                # Right to a range.
                if {$b_range ne ""} {
                    set b [lindex $b_range 1]
                    set range [list $a $b]
                    unset FRESH_IDS($b_range)
                    set changes 1
                }
                set FRESH_IDS($range) 1
            }
        }
    }
}


if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_05]
}
