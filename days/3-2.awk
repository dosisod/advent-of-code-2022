#!/bin/awk

BEGIN {
	temp="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for (i=1; i<=52; i++) priorities[substr(temp, i, 1)] = i
}

{
	offset=((NR - 1) % 3) + 1

	for (i=1; i<=length($0); i++)
		if (counts[char=substr($0, i, 1)] == offset - 1)
			counts[found=char]=offset
}

NR % 3 == 0 {
	delete counts
	sum += priorities[found]
}

END { print sum }
