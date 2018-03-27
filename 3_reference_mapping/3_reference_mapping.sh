refmappath=`tail -n+1 ref_map_params.txt | head -n1`;
picard=`tail -n+2 ref_map_params.txt | head -n1`;
numbercores=`tail -n+3 ref_map_params.txt | head -n1`;
minread=`tail -n+4 ref_map_params.txt | head -n1`;
gatk38=`tail -n+5 ref_map_params.txt | head -n1`;

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
gatk HaplotypeCaller -R $refname -I tempsortmarked.bam -stand-call-conf 30 -O temp_raw_variants.vcf --max-num-haplotypes-in-population 1
java -jar $gatk38 -T FindCoveredIntervals -R $refname -I tempsortmarked.bam -cov $minread -o temp_covered.list
java -jar $gatk38 -T FastaAlternateReferenceMaker -V temp_raw_variants.vcf -R $refname -L temp_covered.list -o $assemblyname.fasta
rm temp*
bwa index -a is $assemblyname.fasta
samtools faidx $assemblyname.fasta
picarddict=`echo $assemblyname.fasta | sed 's/.fasta/.dict/g'`
java -jar $picard CreateSequenceDictionary R=$assemblyname.fasta O=$picarddict
bwa mem -t $numbercores $assemblyname.fasta $left $right > temp.sam
java -jar $picard AddOrReplaceReadGroups I=temp.sam O=tempsort.sam SORT_ORDER=coordinate LB=rglib PL=illumina PU=phase SM=everyone
java -jar $picard MarkDuplicates MAX_FILE_HANDLES=1000 I=tempsort.sam O=tempsortmarked.sam M=temp.metrics AS=TRUE
java -jar $picard SamFormatConverter I=tempsortmarked.sam O=tempsortmarked.bam
samtools index tempsortmarked.bam
java -jar $gatk38 -T FindCoveredIntervals -R $assemblyname.fasta -I tempsortmarked.bam -cov $minread -o temp_covered.list
sed  's/:\|-/\t/gi' temp_covered.list > test.bed
samtools mpileup -f $assemblyname.fasta -l temp.bed tempsortmarked.bam > $assemblyname.pileup
rm temp*
rm -rf *.dict
rm -rf *.fai
rm -rf *.sa
rm -rf *.amb
rm -rf *.ann
rm -rf *.bwt
rm -rf *.pac
done
