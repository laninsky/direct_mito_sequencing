trinitypath=`tail -n+1 mito_shell_params.txt | head -n1`;
samplesfilepath=`tail -n+2 mito_shell_params.txt | head -n1`;
maxmemory=`tail -n+3 mito_shell_params.txt | head -n1`;
numbercores=`tail -n+4 mito_shell_params.txt | head -n1`;



$trinitypath --seqType fq --max_memory $maxmemory --samples_file $samplesfilepath --CPU $numbercores --full_cleanup
