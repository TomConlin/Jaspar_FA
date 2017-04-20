#!/usr/bin/awk -f
# motif_set_jacard.awk
# the order is not actually important 
# cut -f2 gene_mset_1k.tab| sort -nru | motif_set_jacard.awk


function hamming(bits){
	weight=0
	while(bits){
		weight++;
		bits=and(bits,bits-1)
	}
	return weight
}

{	
	a[NR] = $1
}
END{
	for(i=1 ;i<NR; i++){
		for(j=i+1; j<=NR; j++){
			numer = hamming(and(a[i],a[j]))
			denom = hamming(or(a[i],a[j]))
			# when I have nothing to say my lips are sealed
			if((denom > 0) && (numer > 0)) 
				print a[i] "\t" a[j] "\t" numer / denom
		}
	} 
}
