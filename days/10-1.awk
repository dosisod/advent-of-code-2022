#/bin/awk

BEGIN { x=1 }

function check() {
	cycles++

	if (((cycles + 20) % 40) == 0) sum += cycles * x
}

/addx/ {
	check()
	check()
	x+=$2
}

/noop/ { check() }

END { print sum }
