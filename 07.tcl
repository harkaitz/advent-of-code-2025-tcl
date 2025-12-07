#!/usr/bin/env tclsh
proc aoc_07 { } {
    set input  [aoc_read "07.data"]
    set table  [table $input]
    set size   [table_size $table]
    set src    [lindex [sources $table] 0]
    set splits    [part1 $table {*}$size $src]
    set timelines [part2 $table {*}$size $src]
    return [list $splits $timelines]
}
proc table { input } {
    return [lmap line [split $input "\n"] { split $line "" }]
}
proc table_size { table } {
    set first [lindex $table 0]
    return [list [llength $table] [llength $first]]
}
proc sources { table } {
    set sources {}
    lassign [table_size $table] Y X
    for {set x 0} {$x < $X} {incr x} {
        for {set y 0} {$y < $Y} {incr y} {
            if {[lindex $table $y $x] eq "S"} {
                lappend sources [list $y $x]
            }
        }
    }
    return $sources
}
proc part1 { table Y X src } {
    global SKIP
    set splits 0
    lassign $src y x
    for {set y [lindex $src 0]} { $y < $Y } {incr y} {

        if {[info exists SKIP([list $y $x])]} {
            break
        }

        if {[lindex $table $y $x] eq "^"} {
            set SKIP([list $y $x]) 1
            set x1 [expr { $x - 1 }]
            set x2 [expr { $x + 1 }]
            incr splits 1
            if {$x1 >= 0} {
                incr splits [part1 $table $Y $X [list $y $x1]]
            }
            if {$x2 < $X} {
                incr splits [part1 $table $Y $X [list $y $x2]]
            }
            break
        }
    }
    return $splits
}
proc part2 { table Y X src } {
    global CACHE
    if {[info exists CACHE($src)]} {
        return $CACHE($src)
    }
    set timelines 1
    lassign $src y x
    for {set y [lindex $src 0]} { $y < $Y } {incr y} {
        if {[lindex $table $y $x] eq "^"} {
            set x1 [expr { $x - 1 }]
            set x2 [expr { $x + 1 }]
            incr timelines -1
            if {$x1 >= 0} {
                incr timelines [part2 $table $Y $X [list $y $x1]]
            }
            if {$x2 < $X} {
                incr timelines [part2 $table $Y $X [list $y $x2]]
            }
            break
        }
    }
    return [set CACHE($src) $timelines]
}
if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_07]
}
