# 1_denovo.sh
1_denovo.sh will wrap the various programs needed for denovo assembly of your mitogenomes (mostly Trinity), but it needs a few things from you:
1) Cleaned (of adaptors/low-quality bases) paired end sequence files (i.e. R1.fq.gz and R2.fq.gz) for each sample
2) samtools installed in your $PATH (Trinity dependency)
3) jellyfish installed in your $PATH (Trinity dependency)
4) salmon installed in your $PATH (Trinity dependency)
5) A parameters file (mito_shell_params.txt), described below
6) A samples_file (described below too)

# The parameters file (mito_shell_params.txt)
To run, mito_shell.sh needs a parameters file (mito_shell_params.txt) with the following:
```
path/to/trinity/executable
path/to/samples_file/with/read/locations
max_memory
number_of_cores
```
e.g. (remove comments if copying and pasting)
```
Trinity          # Already installed in path, so "Trinity" is all that is needed to call the program
samples_file.txt # See below for an example of what the samples_file should look like (tab delimited: name, R1.fq.gz, R2.fq.gz)
200G             # the max amount of memory you want to allow Trinity to use
8                # the number of CPUs you wish to utilize
```

# The samples_file  (tab-delimited: sample name, R1.fq, R2.fq)
```
B1	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R2.fq.gz
B2	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R2.fq.gz
B3	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R2.fq.gz
B4	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R2.fq.gz
B5	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R2.fq.gz
B6	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R2.fq.gz
B7	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R2.fq.gz
B8	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R2.fq.gz
B9	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R2.fq.gz
B10	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R2.fq.gz
```
# To execute 1_denovo.sh:
Make sure mito_shell_params.txt is in the same directory as 1_denovo.sh, and then...
```
bash 1_denovo.sh
```
