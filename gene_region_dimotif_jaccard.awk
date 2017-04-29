#!/usr/bin/gawk -f
# dimotif_jacard.awk

# gawk is explicit so because subarrays

# cut -f1-4 gene_m1_m2_dx_1k.tab| sort -u|./gene_region_dimotif_jacard.awk motif.list -

FNR==NR{
	mid[$1]=NR
	r=0
}
FNR!=NR && gr != $1"\t"$2 {r++;gr=$1"\t"$2; gene[r]=gr}

FNR!=NR &&  gr == $1"\t"$2{
	# upstream region of a gene has a dimotif
	a[r][FNR] = mid[$3] * 256 + mid[$4]
}

END{
	R=length(gene)
	for(i=1; i<R; i++){
		for(j=i+1; j<=R; j++){
			for(ii in a[i]){
				b[a[i][ii]]=1
				for(jj in a[j]){
					numer += a[i][ii]==a[j][jj]?1:0
					b[a[j][jj]]=1
				} # gene 2 dimotif
			} # gene 1 dimotif
			denom = length(b)
			# when I have nothing to say my lips are sealed
            # filtering everything closer to zero than about a half 
			# -- belay this filtering. collapsing by ncbi gene & region does it.
			if((denom > 0) && (numer > 0) )#&& (lshift(numer,1) > denom))
				print gene[i] "\t" gene[j] "\t" numer / denom
			delete(b)
			numer = denom = 0
		} # gene 2
	} # gene 1
} # geome
