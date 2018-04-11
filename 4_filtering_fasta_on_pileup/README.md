4_filtering_fasta_on_pileup works by shoving filtering_fasta_on_pileup.R into the directory with your pileup files (suffixed by *.pileup) and running it by:
```
Rscript filtering_fasta_on_pileup.R
```

This script determines the consensus sequence in the mpileup file and outputs a fasta file for each pileup containing sequence(s) (for positions where the reference is covered by reads).

We do this additional step over just using the reference output by GATK's haplotypecaller, particularly for instances where we are using PCR-enrichment to generate our mitogenomes. This is because there are a few issues with using amplicons with Haplotypecaller (paraphrasing some of the discussion at the following link as well as associated posts: https://gatkforums.broadinstitute.org/gatk/discussion/8477/two-validated-variants-missed-by-haplotypecaller-using-mip-data-amplicon-like-data):
-- if you have high-coverage sequencing, some of the variants it finds will be PCR or sequencing noise. Haplotypecaller counts these errors against the max-num-haplpotypes/alleles/variants flags so you can get legit variation masked by the noise (when it constructs haplotypes incorporating the noise and those 'real variants' not ouput).
-- if the variant occurs towards the end of a fragment GATK doesn't trust it (because typically ends of reads are noisy with error, but in the case of an amplicon, sometimes the end of the read can legit be covering a nearby variant site).

In addition to outputting the fasta_file, the script will also output a pdf plot for each pileup showing coverage across the mitogenome, percentage of reads that started and stopped at each position, positions where a single nucleotide did not represent >70% of reads (and the subset of these positions where indels were indicated). The >70% cut-off for quality follows Morin et al. (2018), and such sites could be in need of additional scrutiny.
