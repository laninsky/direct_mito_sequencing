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
bwa mem -t $numbercores $refname $left $right > temp.sam
java -jar $picard AddOrReplaceReadGroups I=temp.sam O=tempsort.sam SORT_ORDER=coordinate LB=rglib PL=illumina PU=phase SM=everyone
java -jar $picard MarkDuplicates MAX_FILE_HANDLES=1000 I=tempsort.sam O=tempsortmarked.sam M=temp.metrics AS=TRUE


java -jar $picard SamFormatConverter I=tempsortmarked.sam O=tempsortmarked.bam
samtools index tempsortmarked.bam
/public/jdk1.8.0_112/bin/java -jar /public/GenomeAnalysisTK.jar -T RealignerTargetCreator -R sle117_final_mitobim.fasta -I tempsortmarked.bam -o tempintervals.list
/public/jdk1.8.0_112/bin/java -jar /public/GenomeAnalysisTK.jar -T IndelRealigner -R sle117_final_mitobim.fasta -I tempsortmarked.bam -targetIntervals tempintervals.list -o temp_realigned_reads.bam
/public/jdk1.8.0_112/bin/java -jar /public/GenomeAnalysisTK.jar -T DepthOfCoverage -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam -o temp.coverage

/public/jdk1.8.0_112/bin/java -jar /public/GenomeAnalysisTK.jar -T HaplotypeCaller -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam --genotyping_mode DISCOVERY -stand_call_conf 30 -o temp_raw_variants.vcf --maxNumHaplotypesInPopulation 1
/public/jdk1.8.0_112/bin/java -jar /public/GenomeAnalysisTK.jar -T ReadBackedPhasing -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam  --variant temp_raw_variants.vcf -o temp_phased_SNPs.vcf
/public/jdk1.8.0_112/bin/java -jar /public/GenomeAnalysisTK.jar -T FindCoveredIntervals -R sle117_final_mitobim.fasta -I temp_realigned_reads.bam -cov 4 -o temp_covered.list
/public/jdk1.8.0_112/bin/java -jar /public/GenomeAnalysisTK.jar -T FastaAlternateReferenceMaker -V temp_phased_SNPs.vcf -R sle117_final_mitobim.fasta -L temp_covered.list -o $assemblyname.fasta
samtools pileup -f sle117_final_mitobim.fasta -l temp_covered.list temp_realigned_reads.bam > $assemblyname.pileup

rm -rf *.fai
rm -rf *.sa
rm -rf *.amb
rm -rf *.ann
rm -rf *.bwt
rm -rf *.pac

mv temp.coverage coverage.txt
rm temp*


$trinitypath --seqType fq --max_memory $maxmemory --left $left --right $right --CPU $numbercores --output  ${samplename}_trinity_out_dir --full_cleanup >> 1_denovo.log
rm ${samplename}_trinity_out_dir.fasta.gene_trans_map;
done
