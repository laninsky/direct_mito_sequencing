makeblastdb=`tail -n+5 mito_shell_params.txt | head -n1`;
blastn=`tail -n+6 mito_shell_params.txt | head -n1`;
seqtk=`tail -n+7 mito_shell_params.txt | head -n1`;
step1fasta=`tail -n+8 mito_shell_params.txt | head -n1`;
reference=`tail -n+9 mito_shell_params.txt | head -n1`;
blastperc=`tail -n+10 mito_shell_params.txt | head -n1`;

if [ "$step1fasta" == "Step_1" ];
then 
samplesfilepath=`tail -n+2 mito_shell_params.txt | head -n1`;
numberofsamples=`wc -l $samplesfilepath | awk '{print $1}'`;
for i in `seq 1 $numberofsamples`; 
do samplename=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $1}'`;



else
numberofsamples=`wc -l $step1fasta | awk '{print $1}'`;
for i in `seq 1 $numberofsamples`; 
do samplename=`tail -n+$i $step1fasta | head -n1 | awk '{print $1}'`;


fi



for i in `seq 1 $numberofsamples`; 
do samplename=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $1}'`;
left=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $2}'`;
right=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $3}'`;
$trinitypath --seqType fq --max_memory $maxmemory --left $left --right $right --CPU $numbercores --output  ${samplename}_trinity_out_dir --full_cleanup >> 1_denovo.log
rm ${samplename}_trinity_out_dir.fasta.gene_trans_map;
done
