#!/bin/awk

{
	sub(",", "-")
	split($0, arr, "-")

	for (i=arr[1]; i <= arr[2]; i++) overlap[i]++;
	for (i=arr[3]; i <= arr[4]; i++) overlap[i]++;
	for (i=0; i<length(overlap); i++) if (overlap[i] == 2) { sum += 1; break }

	delete overlap
}

END { print sum }
