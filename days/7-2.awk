#!/bin/awk

/\$ cd \.\./ { depth-- }
/\$ cd [^.]+/ { cwd[depth++] = $3 }

/^[0-9]+/ {
	for (i=depth; i>0; i--) {
		path="/"
		for (j=1; j<i; j++) path=path cwd[j] "/"

		dir_sizes[path]+=$1
	}
}

END {
	min_needed=dir_sizes["/"] - 40000000
	min=dir_sizes["/"]

	for (path in dir_sizes)
		if (dir_sizes[path] < min && dir_sizes[path] > min_needed)
			min=dir_sizes[path]

	print min
}
