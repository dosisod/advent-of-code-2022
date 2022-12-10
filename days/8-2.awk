#!/bin/awk

{ for (x=0; x<length($0); x++) trees[NR - 1][x] = substr($0, x + 1, 1) }

END {
	for (y=0; y<length(trees); y++) {
		for (x=0; x<length(trees[0]); x++) {
			tree=trees[y][x]

			# counting north
			for (north=1; north<y; north++)
				if (trees[y-north][x]>=tree) break

			# counting south
			for (south=1; south<length(trees)-y; south++)
				if (trees[y+south][x]>=tree) break

			# counting east
			for (east=1; east<x; east++)
				if (trees[y][x-east]>=tree) break

			# counting west
			for (west=1; west<length(trees)-x-1; west++)
				if (trees[y][x+west]>=tree) break

			total = north * east * south * west

			if (total > highest) highest = total;
		}
	}

	print highest
}
