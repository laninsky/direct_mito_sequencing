3_reference_mapping.sh will wrap the various programs needed for a reference assembly of your mitogenomes, but it needs a few things from you:

1. Cleaned (of adaptors/low-quality bases) paired end sequence files (i.e. R1.fq.gz and R2.fq.gz) for each sample
2. Fasta reference(s) you want to assemble to
3. samtools installed in your $PATH 
4. bwa installed in your $PATH
5. GATK installed in your $PATH (tested on v 4+ of GATK)
6. picard installed (you'll give the path in ref_map_params.txt, decribed below)
7. A parameters file (ref_map_params.txt), described below
8. A ref_map_file (described below too)

# The parameters file (ref_map_params.txt)
To run, 3_reference_mapping.sh needs a parameters file (ref_map_params.txt) with the following:
```
path/to/ref_map_file/with/references/and/read/files
path/to/picard.jar
number_of_cores
min_read_depth_required
```
e.g. (remove comments if copying and pasting)
```
wasp_ref_map_file.txt                     # See below for an example of what the ref_map_file should look like (tab-delimited: fasta_reference, R1.fq, R2.fq)
/usr/local/picard-tools-2.18.0/picard.jar # path to picard installation            
8                                         # the number of CPUs you wish to utilize
1                                         # The min coverage required (areas below this will not be output and regions of low coverage will be used to split up contigs
```

# ref_map_file (tab-delimited: fasta_reference, R1.fq, R2.fq)
We have found that "re-linearizing" the reference can be handy for recovering reads which span the artificial break point in the original reference (the "split" references in the example below).
```
B1_new_reference_4th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R2.fq.gz
B1_new_reference_4th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R2.fq.gz
B2_new_reference_7th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R2.fq.gz
B2_new_reference_7th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R2.fq.gz
B3_new_reference_7th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R2.fq.gz
B3_new_reference_7th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R2.fq.gz
B4_new_reference_11th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R2.fq.gz
B4_new_reference_11th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R2.fq.gz
B5_new_reference_8th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R2.fq.gz
B5_new_reference_8th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R2.fq.gz
B6_new_reference_4th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R2.fq.gz
B6_new_reference_4th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R2.fq.gz
B7_new_reference_3rd_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R2.fq.gz
B7_new_reference_3rd_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R2.fq.gz
B8_new_reference_8th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R2.fq.gz
B8_new_reference_8th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R2.fq.gz
B9_new_reference_4th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R2.fq.gz
B9_new_reference_4th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R2.fq.gz
B10_new_reference_5th_iteration.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R2.fq.gz
B10_new_reference_5th_iteration_split.fasta	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R2.fq.gz
```
