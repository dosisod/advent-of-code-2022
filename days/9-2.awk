#!/bin/awk

BEGIN {
	for (k=0; k<=9; k++) knot_xs[k]=knot_ys[k]=0
	visited[0,0]=1
}

function abs(num) { return sqrt(num^2) }
function sign(num) { return num==0 ? 0 : (num/abs(num)) }

function move(dx, dy) {
	for (i=0; i<abs(dx)*10; i++) step(sign(dx), 0, i % 10)
	for (i=0; i<abs(dy)*10; i++) step(0, sign(dy), i % 10)
}

function step(dx, dy, knot) {
	if (knot == 0) {
		knot_xs[0] += sign(dx)
		knot_ys[0] += sign(dy)
		return
	}

	diff_x=knot_xs[knot - 1] - knot_xs[knot]
	diff_y=knot_ys[knot - 1] - knot_ys[knot]
	mag_x=sign(diff_x)
	mag_y=sign(diff_y)

	if (abs(diff_x) >= 2) {
		knot_xs[knot] += mag_x
		if (diff_y != 0) knot_ys[knot] += mag_y
	}
	else if (abs(diff_y) >= 2) {
		knot_ys[knot] += mag_y
		if (diff_x != 0) knot_xs[knot] += mag_x
	}

	visited[knot_xs[9],knot_ys[9]]=1
}

/U/ { move(0, $2) }
/D/ { move(0, -$2) }
/L/ { move(-$2, 0) }
/R/ { move($2, 0) }

END { print length(visited) }
