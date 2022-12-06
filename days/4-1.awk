#!/bin/awk

{
	sub(",", "-")
	split($0, arr, "-")

	if ((arr[1] <= arr[3] && arr[2] >= arr[4]) || (arr[1] >= arr[3] && arr[2] <= arr[4]))
		sum += 1
}

END { print sum }
