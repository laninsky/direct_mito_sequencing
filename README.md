# direct_mito_sequencing

You've got targetted next-generation sequencing data of mitogenomes and now you want to do a de novo assembly of the mitogenomes, followed by reference mapping to obtain coverage data for each of your samples.

Because you might want to use different assemblies/already have "proto" mitochondrial data, we do this in a number of steps so you can join the work flow at whatever step suits you

1_denovo: this subfolder has scripts to use Trinity to de novo assemble your cleaned fastq data (across multiple samples)

2_blast_fishing: this subfolder has scripts to use blast to fish out rough matches to a mitogenome reference

3_reference_mapping: using sample-specific references, carrying out a reference alignment to get coverage for each sample

