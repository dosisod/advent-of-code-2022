#!/bin/awk

{ for (x=0; x<length($0); x++) trees[NR - 1][x] = substr($0, x + 1, 1) }

function mark() {
	tree=trees[y][x]

	if (tree>highest) {
		is_tree_invisible[y][x]=1
		highest=tree
	}
}

END {
	for (y=0; y<length(trees); y++) {
		# East to West
		highest=-1;
		for (x=length(trees[0])-1; x>=0; x--) mark()

		# West to East
		highest=-1;
		for (x=0; x<length(trees[0]); x++) mark()
	}

	for (x=0; x<length(trees[0]); x++) {
		# North to South
		highest=-1;
		for (y=0; y<length(trees); y++) mark()

		# South to North
		highest=-1;
		for (y=length(trees)-1; y>=0; y--) mark()
	}

	for (y=0; y<length(trees); y++)
		for (x=0; x<length(trees[0]); x++)
			count+=is_tree_invisible[y][x]

	print count
}
