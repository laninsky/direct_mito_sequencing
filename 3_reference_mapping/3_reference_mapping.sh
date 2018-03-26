refmappath=`tail -n+1 ref_map_params.txt | head -n1`;
picard=`tail -n+2 ref_map_params.txt | head -n1`;
numbercores=`tail -n+3 ref_map_params.txt | head -n1`;
minread=`tail -n+4 ref_map_params.txt | head -n1`;

numberofsamples=`wc -l $refmappath | awk '{print $1}'`

for i in `seq 1 $numberofsamples`; 
do refname=`tail -n+$i $refmappath | head -n1 | awk '{print $1}'`;
left=`tail -n+$i $refmappath | head -n1 | awk '{print $2}'`;
right=`tail -n+$i $refmappath | head -n1 | awk '{print $3}'`;


$trinitypath --seqType fq --max_memory $maxmemory --left $left --right $right --CPU $numbercores --output  ${samplename}_trinity_out_dir --full_cleanup >> 1_denovo.log
rm ${samplename}_trinity_out_dir.fasta.gene_trans_map;
done
