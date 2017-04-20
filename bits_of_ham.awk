#! /usr/bin/awk -f
# given a line of bits
# return the number set and an integer representation (bit vector signature)
{
	ham = bit = 0
	for(i=1; i<=NF; i++){

		if($i == "1"){
			ham ++
			bit += (2^i)
		}
	}
	print ham "\t" bit
}
