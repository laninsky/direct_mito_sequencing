trinitypath=`tail -n+1 phasing_settings | head -n1`;
samplesfilepath=`tail -n+2 phasing_settings | head -n1`;
numbercores=`tail -n+3 phasing_settings | head -n1`;


sequencing=`tail -n+4 phasing_settings | head -n1`;



$trinitypath --seqType fq --max_memory 200GB --samples_file $samplesfilepath -
