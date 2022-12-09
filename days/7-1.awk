#!/bin/awk

# correct: 1582412

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
	for (path in dir_sizes) if ((size=dir_sizes[path]) <= 100000) total+=size

	print total
}
