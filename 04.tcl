#!/usr/bin/env tclsh
proc aoc_04 { } {
    set input [aoc_read "04.data"]
    return [list [parse $input; part1] [parse $input; part2]]
}
proc part1 { } {
    global MAP MAP_X MAP_Y
    set accessible 0
    for {set y 0} {$y < $MAP_Y} {incr y} {
        for {set x 0} {$x < $MAP_X} {incr x} {
            if {$MAP($y,$x) ne "@"} {
                continue
            }
            if {[neighbours $y $x] < 4} {
                set MAP($y,$x) "X"
                incr accessible
            }
        }
    }
    return $accessible
}
proc part2 { } {
    global MAP MAP_X MAP_Y
    set accessible      0
    set accessible_old -1
    while {$accessible > $accessible_old} {
        set accessible_old $accessible
        for {set y 0} {$y < $MAP_Y} {incr y} {
            for {set x 0} {$x < $MAP_X} {incr x} {
                if {$MAP($y,$x) ne "@"} {
                    continue
                }
                if {[neighbours $y $x] < 4} {
                    set MAP($y,$x) "."
                    incr accessible
                }
            }
        }
    }
    return $accessible
}
proc neighbours { y x } {
    global MAP MAP_X MAP_Y
    set neighbours 0
    foreach d {
        {-1 -1} {-1 0} {-1 1}
        { 0 -1}        { 0 1}
        { 1 -1} { 1 0} { 1 1}
    } {
        set ay [expr {$y + [lindex $d 0]}]
        set ax [expr {$x + [lindex $d 1]}]
        if {$ay >= 0 && $ay < $MAP_Y && $ax >= 0 && $ax < $MAP_X && $MAP($ay,$ax) ne "."} {
            incr neighbours
        }
    }
    return $neighbours
}
proc parse { input } {
    global MAP MAP_X MAP_Y
    set y 0
    foreach line [split $input "\n"] {
        set x 0
        foreach char [split $line ""] {
            set MAP($y,$x) $char
            incr x
        }
        incr y 
    }
    set MAP_X $x
    set MAP_Y $y
}
# --------------------------------------------------------------------
proc print { } { # not used
    global MAP MAP_X MAP_Y
    for {set y 0} {$y < $MAP_Y} {incr y} {
        for {set x 0} {$x < $MAP_X} {incr x} {
            puts -nonewline stderr $MAP($y,$x)
        }
        puts stderr ""
    }
}
# --------------------------------------------------------------------
if {[file tail $argv0] eq [file tail [info script]]} {
    source "rd.tcl"
    puts [aoc_04]
}
