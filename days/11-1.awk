#!/bin/awk

BEGIN { monkey=0 }

/Starting.items/ { split(substr($0, 19), items[monkey], ", ") }

/Operation/ {
	opcodes[monkey]=$5
	opcode_args[monkey]=$6
}

/Test/ { divisibles[monkey]=$4 }

/If.true/ { if_true[monkey]=$6 }
/If.false/ { if_false[monkey]=$6 }

/^$/ { monkey++ }

END {
	total_monkies=monkey

	for (round=0; round<20; round++) {
		for (monkey=0; monkey<=total_monkies; monkey++) {
			len=length(items[monkey])

			for (i=1; i<=len; i++) {
				inspections[monkey]++
				item = items[monkey][i]

				op_arg=opcode_args[monkey]
				if (op_arg == "old") op_arg = item

				if (opcodes[monkey] == "+") { item += op_arg }
				else { item *= op_arg }

				item = int(item / 3)

				new_monkey = (item % divisibles[monkey] == 0) ?
					if_true[monkey] :
					if_false[monkey]

				items[new_monkey][length(items[new_monkey]) + 1] = item
				delete items[monkey][i]
			}
		}
	}

	asort(inspections)
	print inspections[total_monkies] * inspections[total_monkies + 1]
}
