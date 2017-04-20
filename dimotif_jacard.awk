#!/usr/bin/gawk -f
# dimotif_jacard.awk 

# gawk is explicit so because subarrays  

# cut -f1-3 refseq_m1_m2_dist_1k.tab| sort -u|./dimotif_jacard.awk motif.list - 

FNR==NR{
	mid[$1]=NR
	r=0
}
FNR!=NR && rs != $1 {r++;rs=$1; gene[r]=$1}

FNR!=NR && rs == $1 {
	# upstream region of a gene has a dimotif
	a[r][FNR] = mid[$2] * 256 + mid[$3]
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
			if((denom > 0) && (numer > 0) && (lshift(numer,1) > denom))  
				print gene[i] "\t" gene[j] "\t" numer / denom
			delete(b)
			numer = denom = 0
		} # gene 2  
	} # gene 1 
} # geome
