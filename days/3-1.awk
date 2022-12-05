#!/bin/awk

BEGIN {
	temp="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for (i=1; i<=52; i++) priorities[substr(temp, i, 1)] = i
}

{
	len=length($0) / 2

	for (i=1; i <= len; i++) items[substr($0, i, 1)]=1

	for (i=1; i <= len; i++)
		if (items[common_item=substr($0, i + len, 1)])
			break

	delete items
	sum += priorities[common_item]
}

END { print sum }
