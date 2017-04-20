#! /usr/bin/awk -f

# make_fagene_motif_table.awk FA_NCBIGene_symbol.txt GENE_JASPAR_bucket_count.tab
NR==FNR{
	gene[$1]=$2
}

$3=="1k" && $1 in gene{
	table1k[$1,$2]=$4
    gene1k[$1]++
	motif1k[$2]++
	tally1k[$2]+=$4
}
$3=="2k" $1 in gene{
	table2k[$1,$2]=$4
    gene2k[$1]++
	motif2k[$2]++
	tally2k[$2]+=$4
}
$3=="5k" $1 in gene{
	table5k[$1,$2]=$4
    gene5k[$1]++
	motif5k[$2]++
	tally5k[$2]+=$4
}
END{
	g=asorti(gene1k, row)
	m=asorti(motif1k, col)
	#line = "gene\t"
	#for(j=1;j<=m;j++){line = line " " col[j]}
	print line
	for(i=1;i<=g;i++){
		line=row[i]	"\t"
    	for(j=1;j<=m;j++){
			x= (row[i] SUBSEP col[j]) in table1k?table1k[row[i],col[j]]:0
			line = line "  " x
		}
		print line
    }	
	print ""		
}
