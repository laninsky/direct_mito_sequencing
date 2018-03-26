3_reference_mapping.sh will wrap the various programs needed for a reference assembly of your mitogenomes, but it needs a few things from you:

1. Cleaned (of adaptors/low-quality bases) paired end sequence files (i.e. R1.fq.gz and R2.fq.gz) for each sample
2. Fasta reference(s) you want to assemble to
3. samtools installed in your $PATH 
4. bwa installed in your $PATH
5. GATK installed in your $PATH
6. picard installed in your $PATH
7. A parameters file (ref_map_params.txt), described below
8. A ref_map_file (described below too)
