#!/bin/awk

BEGIN { parsing_crates=1 }

parsing_crates { rows[NR]=$0 }

function move(from, to) {
	from_top=length(crates[from])

	crates[to][length(crates[to])] = crates[from][from_top - 1]
	delete crates[from][from_top - 1]
}

function movemany(count, from, to) {
	for (i=0; i<count; i++) move(from, to)
}

!parsing_crates { movemany($2, $4, $6) }

/^[ 0-9]+$/ {
	parsing_crates=0

	for (col=1; col<=NF; col++) {
		for (row=0; row<(NR - 1); row++) {
			crates[col][row] = substr(rows[NR - row - 1], ((col - 1) * 4) + 2, 1)
			if (crates[col][row] == " ") delete crates[col][row]
		}
	}

	getline
}

END {
	for (i=1; i<=length(crates); i++) printf crates[i][length(crates[i]) - 1]

	print ""
}
