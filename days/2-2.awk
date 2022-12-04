#!/bin/awk

# A=1=rock
# B=2=paper
# C=3=scissors

{
	if ($1 == "A") them=1
	if ($1 == "B") them=2
	if ($1 == "C") them=3

	# you must loose
	if ($2 == "X") {
		offset=1
		outcome=0
	}
	# you must draw
	if ($2 == "Y") {
		offset=2
		outcome=3
	}
	# you must win
	if ($2 == "Z") {
		offset=0
		outcome=6
	}

	you=((them + offset) % 3) + 1

	score += you + outcome
}

END { print score }
