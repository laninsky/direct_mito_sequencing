makeblastdb=`tail -n+5 mito_shell_params.txt | head -n1`;
blastn=`tail -n+6 mito_shell_params.txt | head -n1`;
seqtk=`tail -n+7 mito_shell_params.txt | head -n1`;
step1fasta=`tail -n+8 mito_shell_params.txt | head -n1`;
reference=`tail -n+9 mito_shell_params.txt | head -n1`;
blastperc=`tail -n+10 mito_shell_params.txt | head -n1`;

grep -v '^$' $reference > reference_no_blank_lines.fasta
$makeblastdb -in reference_no_blank_lines.fasta -dbtype nucl

if [ "$step1fasta" == "Step_1" ];
then 
samplesfilepath=`tail -n+2 mito_shell_params.txt | head -n1`;
numberofsamples=`wc -l $samplesfilepath | awk '{print $1}'`;
for i in `seq 1 $numberofsamples`; 
do samplename=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $1}'`;
$blastn -db reference_no_blank_lines.fasta -query ${samplename}_trinity_out_dir.Trinity.fasta -perc_identity $blastperc -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist;

done

else
numberofsamples=`wc -l $step1fasta | awk '{print $1}'`;
for i in `seq 1 $numberofsamples`; 
do samplename=`tail -n+$i $step1fasta | head -n1 | awk '{print $1}'`;
samplefasta=`tail -n+$i $step1fasta | head -n1 | awk '{print $2}'`
$blastn -db reference_no_blank_lines.fasta -query $samplefasta -perc_identity $blastperc -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist;

done
fi
