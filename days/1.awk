#!/bin/awk

/^$/ {
	highest = (current > highest) ? current : highest
	current = 0
}

{ current += $0 }

END { print highest }
