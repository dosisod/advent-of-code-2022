#!/bin/awk

/^$/ {
	groups[i++] = current
	current = 0
}

{ current += $0 }

END {
	len = asort(groups)
	for (i = 0; i < 3; i++) total += groups[len - i]
	print total
}
