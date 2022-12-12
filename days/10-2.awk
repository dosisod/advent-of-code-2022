#/bin/awk

BEGIN { x=1 }

function check() {
	if (cycles % 40 == 0) print ""

	printf (sqrt(((cycles % 40) - x) ^ 2) > 1) ? " " : "\xe2\x96\x88"

	cycles++
}

/addx/ {
	check()
	check()
	x+=$2
}

/noop/ { check() }
