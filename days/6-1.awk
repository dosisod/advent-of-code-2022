#!/bin/awk

{
	MAX_LEN=4

	for (i=1; i<=length($0); i++) {
		if (i > MAX_LEN) {
			count=0
			for (j=0; j<MAX_LEN; j++) count += chars[queue[j]]

			if (count==MAX_LEN) {
				print i - 1
				exit
			}

			chars[queue[(i + MAX_LEN - 1) % MAX_LEN]]--
		}

		char=substr($0, i, 1)
		chars[char]++
		queue[(i - 1) % MAX_LEN]=char
	}
}
