makeblastdb=`tail -n+5 mito_shell_params.txt | head -n1`
blastn=`tail -n+6 mito_shell_params.txt | head -n1`
seqtk=`tail -n+7 mito_shell_params.txt | head -n1`
step1fasta=`tail -n+8 mito_shell_params.txt | head -n1`
reference=`tail -n+9 mito_shell_params.txt | head -n1`
blastperc=`tail -n+10 mito_shell_params.txt | head -n1`

grep -v '^$' $reference > reference_no_blank_lines.fasta
$makeblastdb -in reference_no_blank_lines.fasta -dbtype nucl

if [ "$step1fasta" == "Step_1" ]
then 
samplesfilepath=`tail -n+2 mito_shell_params.txt | head -n1`
numberofsamples=`wc -l $samplesfilepath | awk '{print $1}'`
for i in `seq 1 $numberofsamples`
do samplename=`tail -n+$i $samplesfilepath | head -n1 | awk '{print $1}'`
$blastn -db reference_no_blank_lines.fasta -query ${samplename}_trinity_out_dir.Trinity.fasta -perc_identity $blastperc -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist
$seqtk subseq ${samplename}_trinity_out_dir.Trinity.fasta ${samplename}.namelist | sed 's/>/>'"$samplename"'+/g' >> $samplename.oldblast.fasta
rm ${samplename}.namelist 
$makeblastdb -in $samplename.oldblast.fasta -dbtype nucl
$blastn -db $samplename.oldblast.fasta -query ${samplename}_trinity_out_dir.Trinity.fasta -perc_identity 95 -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist
$seqtk subseq ${samplename}_trinity_out_dir.Trinity.fasta ${samplename}.namelist  | sed 's/>/>'"$samplename"'+/g' >> $samplename.newblast.fasta
oldblastln=`wc -l $samplename.oldblast.fasta | awk '{print $1}'`
oldblastln=$(($oldblastln + 0))
newblastln=`wc -l $samplename.newblast.fasta | awk '{print $1}'`
newblastln=$(($newblastln + 0))

while [[ $oldblastln < $newblastln ]]
do rm -rf *.oldblast.*
mv $samplename.newblast.fasta $samplename.oldblast.fasta
rm ${samplename}.namelist
$makeblastdb -in $samplename.oldblast.fasta -dbtype nucl
$blastn -db $samplename.oldblast.fasta -query ${samplename}_trinity_out_dir.Trinity.fasta  -perc_identity 95 -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist
$seqtk subseq ${samplename}_trinity_out_dir.Trinity.fasta ${samplename}.namelist  | sed 's/>/>'"$samplename"'+/g' >> $samplename.newblast.fasta
oldblastln=`wc -l $samplename.oldblast.fasta | awk '{print $1}'`
oldblastln=$(($oldblastln + 0))
newblastln=`wc -l $samplename.newblast.fasta | awk '{print $1}'`
newblastln=$(($newblastln + 0))
done

rm -rf *.oldblast.*

done

else
numberofsamples=`wc -l $step1fasta | awk '{print $1}'`
for i in `seq 1 $numberofsamples`
do samplename=`tail -n+$i $step1fasta | head -n1 | awk '{print $1}'`
samplefasta=`tail -n+$i $step1fasta | head -n1 | awk '{print $2}'`
$blastn -db reference_no_blank_lines.fasta -query $samplefasta -perc_identity $blastperc -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist
$seqtk subseq $samplefasta ${samplename}.namelist | sed 's/>/>'"$samplename"'+/g' >> $samplename.oldblast.fasta
rm ${samplename}.namelist 
$makeblastdb -in $samplename.oldblast.fasta -dbtype nucl
$blastn -db $samplename.oldblast.fasta -query $samplefasta -perc_identity 95 -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist
$seqtk subseq $samplefasta ${samplename}.namelist  | sed 's/>/>'"$samplename"'+/g' >> $samplename.newblast.fasta
oldblastln=`wc -l $samplename.oldblast.fasta | awk '{print $1}'`
oldblastln=$(($oldblastln + 0))
newblastln=`wc -l $samplename.newblast.fasta | awk '{print $1}'`
newblastln=$(($newblastln + 0))

while [[ $oldblastln < $newblastln ]]
do rm -rf *.oldblast.*
mv $samplename.newblast.fasta $samplename.oldblast.fasta
rm ${samplename}.namelist
$makeblastdb -in $samplename.oldblast.fasta -dbtype nucl
$blastn -db $samplename.oldblast.fasta -query $samplefasta -perc_identity 95 -outfmt '10 qseqid sseqid qlen slen' | cut -d , -f 1 | uniq > $samplename.namelist
$seqtk subseq $samplefasta ${samplename}.namelist  | sed 's/>/>'"$samplename"'+/g' >> $samplename.newblast.fasta
oldblastln=`wc -l $samplename.oldblast.fasta | awk '{print $1}'`
oldblastln=$(($oldblastln + 0))
newblastln=`wc -l $samplename.newblast.fasta | awk '{print $1}'`
newblastln=$(($newblastln + 0))
done

rm -rf *.oldblast.*

done

rm -rf *.namelist
rm -rf reference_no_blank_lines.fasta*

fi
