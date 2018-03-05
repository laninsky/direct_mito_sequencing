# direct_mito_sequencing

You've got targetted next-generation sequencing data of mitogenomes. You've cleaned your data and have paired end sequencing for each file and now you want to do a de novo assembly of the mitogenomes, followed by reference mapping to obtain coverage data for each of your samples.

To run, mito_shell.sh needs a parameters file (mito_shell_params.txt) with the following:
```
path/to/trinity/executable
path/to/samples_file/for/trinity
max_memory
number_of_cores

```
e.g.
```
Trinity # Already installed in path, so "Trinity" is all that is needed to call the program
samples_file.txt # See below for an example of what the samples_file should look like (also see Trinity -h)
200G # the max amount of memory you want to allow Trinity to use
8 # the number of CPUs you wish to utilize

```

# example of samples_file (tab delimited) for Trinity
```
#B1	B1	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B1/B1_R2.fq.gz
#B2	B2	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B2/B2_R2.fq.gz
#B3	B3	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B3/B3_R2.fq.gz
#B4	B4	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B4/B4_R2.fq.gz
#B5	B5	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B5/B5_R2.fq.gz
#B6	B6	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B6/B6_R2.fq.gz
#B7	B7	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B7/B7_R2.fq.gz
#B8	B8	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B8/B8_R2.fq.gz
#B9	B9	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B9/B9_R2.fq.gz
#B10	B10	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R1.fq.gz	/mnt/hcs-gemmell/wasp/mtDNA_data/Cleandata/B10/B10_R2.fq.gz
```
After getting all of this together, execute mito_shell.sh by:
```
bash mito_shell.sh
```
