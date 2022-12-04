#!/bin/awk

# A=X=1=rock
# B=Y=2=paper
# C=Z=3=scissors

{
	if ($1 == "A") them=1
	if ($1 == "B") them=2
	if ($1 == "C") them=3

	if ($2 == "X") you=1
	if ($2 == "Y") you=2
	if ($2 == "Z") you=3

	# draw
	if (you == them) outcome=3
	# you win
	else if (you - 1 == them % 3) outcome=6
	# they win
	else outcome=0

	score += you + outcome
}

END { print score }
