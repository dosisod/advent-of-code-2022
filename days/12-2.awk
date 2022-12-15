#!/bin/awk

BEGIN {
	for (char=0; char<26; char++) char_to_elevation[sprintf("%c", char+97)]=char
	char_to_elevation["E"] = 26
	lvl_a_count=0
}

{
	for (x=0; x<length($0); x++) {
		cell=substr($0, x + 1, 1)

		if ((grid[x][NR - 1]=char_to_elevation[cell]) == 0) {
			lvl_a_xs[lvl_a_count]=x
			lvl_a_ys[lvl_a_count++]=NR - 1
		}

		if (cell == "E") {
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
	queue_xs[len]=x
	queue_ys[len]=y
	seen[x,y]=1

	return x == end_x && y == end_y
}

function run(start, stop) {
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
			) return 1
		}

		len=length(queue_xs)

		if (stop == len) return 0

		start = stop
		stop = len
	}
}

END {
	for (a=0; a<length(lvl_a_xs); a++) {
		delete queue_xs
		delete queue_ys
		delete seen
		total_steps=0
		queue_xs[0]=lvl_a_xs[a]
		queue_ys[0]=lvl_a_ys[a]
		seen[0,0]=1

		reached_end=run(0, 1)

		if (reached_end && (total_steps < min || !min)) min = total_steps
	}

	print min
}
