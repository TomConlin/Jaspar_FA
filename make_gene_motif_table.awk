#! /usr/bin/awk -f

# make_gene_motif_table.awk  GENE_JASPAR_bucket_count.tab

BEGIN{
	bucket[1]="1k"
	bucket[2]="2k"
	bucket[3]="5k"
	while((getline < "ncbigene_symbol.tab")>0){
		gene[ng++] = "NCBIGene:" $1
	}
	print "gene:\t" length(gene)

	while((getline < "motif.list")>0){
		motif[nm++] = "JASPAR:" $1
	}
	print "motif:\t" length(motif)
}

{
	tab[$3,$1,$2]=$4
}

END{
    print "table:\t" length(tab)

	for(b=1; b<4; b++){
		table = ""
		for(g=1; g<=ng; g++){
			row = ""	
			for(m=1; m<=131; m++){		
    		 	if((bucket[b] SUBSEP gene[g] SUBSEP motif[m]) in tab){ 
					x = 1
				} else { 
					x= 0
				}
				row = row " " x
			}
		    table = table row "\n"
		}
		dest = "upstream_bucket_" bucket[b] ".matrix"
		print table > dest		
    }			
}

