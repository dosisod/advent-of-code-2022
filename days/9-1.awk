#!/bin/awk

BEGIN {
	tail_x=tail_y=0
	visited[0,0]=1
}

function abs(num) { return sqrt(num^2) }
function sign(num) { return num==0 ? 0 : (num/abs(num)) }

function move(dx, dy) {
	for (i=0; i<abs(dx); i++) step(sign(dx), 0)
	for (i=0; i<abs(dy); i++) step(0, sign(dy))
}

function step(dx, dy) {
	head_x += dx
	head_y += dy
	diff_x=head_x - tail_x
	diff_y=head_y - tail_y
	mag_x=sign(diff_x)
	mag_y=sign(diff_y)

	if (abs(diff_x) >= 2) {
		tail_x += mag_x
		if (diff_y != 0) tail_y += mag_y
	}

	if (abs(diff_y) >= 2) {
		tail_y += mag_y
		if (diff_x != 0) tail_x += mag_x
	}

	visited[tail_x,tail_y]=1
}

/U/ { move(0, $2) }
/D/ { move(0, -$2) }
/L/ { move(-$2, 0) }
/R/ { move($2, 0) }

END { print length(visited) }
