#!/usr/bin/gawk -f
# dimotif_jacard.awk

# gawk is explicit so because subarrays

# cut -f1-4 gene_m1_m2_dx_1k.tab| sort -u|./gene_region_dimotif_jacard.awk -v"CUTOFF=0.2" motif.list -

FNR==NR{	mid[$1]=NR}
FNR!=NR {	gene[$1][$2][FNR] = mid[$3] * 256 + mid[$4]}

END{for(g1 in gene){
		for(g2 in gene){
			if(g1 > g2){
				for(r1 in gene[g1]){
					delete(ds1);
					for(dm1 in gene[g1][r1]){
						ds1[gene[g1][r1][dm1]]=1;
					}
					delete(ds);
					for(r2 in gene[g2]){
						for(d in ds1){ds[d]=ds1[d]}; 
						for(dm2 in gene[g2][r2]){
							ds[gene[g2][r2][dm2]]=1;
							n += gene[g1][r1][dm1] == gene[g2][r2][dm2] ? 1:0;
						}
						d = length(ds)
						j = n?n/d:0;	
						if(j && (j >= CUTOFF)){ # drop those below CUTOFF
							print g1 "\t" r1 "\t" g2 "\t" r2 "\t" j 
						}
                        delete(ds); n=0;   
					} # r2
				} # r1
			} # ordered
		} # g2
	} # g1
}


