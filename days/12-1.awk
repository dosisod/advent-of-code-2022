#!/bin/awk

BEGIN {
	for (char=0; char<26; char++) char_to_elevation[sprintf("%c", char+97)]=char
	char_to_elevation["E"] = 26
}

{
	for (x=0; x<length($0); x++) {
		cell=substr($0, x + 1, 1)
		grid[x][NR - 1] = char_to_elevation[cell]

		if (cell == "S") {
			start_x=x
			start_y=NR - 1
		}
		else if (cell == "E") {
			end_x=x
			end_y=NR - 1
		}
	}
}

function enqueue(lvl, x, y) {
	if (x < 0 || x >= length(grid) ||\
		y < 0 || y >= length(grid[0]) ||\
		(grid[x][y] > (lvl + 1)) ||\
		seen[x,y]\
	) return 0

	len=length(queue_xs)
	queue_xs[len] = x
	queue_ys[len] = y
	seen[x,y]=1

	return x == end_x && y == end_y
}

function run() {
	start = 0
	stop = 1
	for (;;) {
		total_steps++

		for (i=start; i<stop; i++) {
			x=queue_xs[i]
			y=queue_ys[i]
			lvl=grid[x][y]

			if (enqueue(lvl, x + 1, y) ||\
				enqueue(lvl, x - 1, y) ||\
				enqueue(lvl, x, y + 1) ||\
				enqueue(lvl, x, y - 1)\
			) return total_steps
		}

		len=length(queue_xs)

		if (stop == len) return total_steps

		start = stop
		stop = len
	}
}

END {
	queue_xs[0] = start_x
	queue_ys[0] = start_y
	seen[0,0]=1

	print run()
}
