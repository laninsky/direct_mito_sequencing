trinitypath=`tail -n+1 mito_shell_params.txt | head -n1`;
samplesfilepath=`tail -n+2 mito_shell_params.txt | head -n1`;
maxmemory=`tail -n+3 mito_shell_params.txt | head -n1`;
numbercores=`tail -n+4 mito_shell_params.txt | head -n1`;

numberofsamples=`wc -l $samplesfilepath | awk '{print $1}'`

for i in `seq 1 $numberofsamples`; 
do samplename=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $1}'`;
left=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $2}'`;
right=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $3}'`;
$trinitypath --seqType fq --max_memory $maxmemory --left $left --right $right --CPU $numbercores --output  ${samplename}_trinity_out_dir --full_cleanup >> 1_denovo.log
done
