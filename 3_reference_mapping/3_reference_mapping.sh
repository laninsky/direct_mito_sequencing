refmappath=`tail -n+1 ref_map_params.txt | head -n1`;
picard=`tail -n+2 ref_map_params.txt | head -n1`;
numbercores=`tail -n+3 ref_map_params.txt | head -n1`;
minread=`tail -n+4 ref_map_params.txt | head -n1`;

numberofsamples=`wc -l $refmappath | awk '{print $1}'`

for i in `seq 1 $numberofsamples`; 
do refname=`tail -n+$i $refmappath | head -n1 | awk '{print $2}'`;
left=`tail -n+$i $refmappath | head -n1 | awk '{print $3}'`;
right=`tail -n+$i $refmappath | head -n1 | awk '{print $4}'`;
assemblyname=`tail -n+$i $refmappath | head -n1 | awk '{print $1}'`;
bwa index -a is $refname
samtools faidx $refname 
picarddict=`echo $refname | sed 's/.fasta/.dict/g'`
java -jar $picard CreateSequenceDictionary R=$refname O=$picarddict
bwa mem $refname $left $right > temp.sam

/public/jdk1.8.0_112/bin/java -jar /public/picard.jar AddOrReplaceReadGroups I=temp.sam O=tempsort.sam SORT_ORDER=coordinate LB=rglib PL=illumina PU=phase SM=everyone
/public/jdk1.8.0_112/bin/java -jar /public/picard.jar MarkDuplicates MAX_FILE_HANDLES=1000 I=tempsort.sam O=tempsortmarked.sam M=temp.metrics AS=TRUE
/public/jdk1.8.0_112/bin/java -jar /public/picard.jar SamFormatConverter I=tempsortmarked.sam O=tempsortmarked.bam
samtools index tempsortmarked.bam
gatk -T RealignerTargetCreator -R sle117_final_mitobim.fasta -I tempsortmarked.bam -o tempintervals.list
gatk  -T IndelRealigner -R sle117_final_mitobim.fasta -I tempsortmarked.bam -targetIntervals tempintervals.list -o temp_realigned_reads.bam
gatk -T DepthOfCoverage -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam -o temp.coverage

gatk -T HaplotypeCaller -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam --genotyping_mode DISCOVERY -stand_call_conf 30 -o temp_raw_variants.vcf --maxNumHaplotypesInPopulation 1
gatk -T ReadBackedPhasing -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam  --variant temp_raw_variants.vcf -o temp_phased_SNPs.vcf
gatk -T FindCoveredIntervals -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam -cov 4 -o temp_covered.list
gatk -T FastaAlternateReferenceMaker -V temp_phased_SNPs.vcf -R sle117_final_mitobim.fasta -L temp_covered.list -o sle117_final_mapped.fasta
mv temp.coverage coverage.txt
rm temp*


$trinitypath --seqType fq --max_memory $maxmemory --left $left --right $right --CPU $numbercores --output  ${samplename}_trinity_out_dir --full_cleanup >> 1_denovo.log
rm ${samplename}_trinity_out_dir.fasta.gene_trans_map;
done
