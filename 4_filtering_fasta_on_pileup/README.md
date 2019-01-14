4_filtering_fasta_on_pileup works by shoving filtering_fasta_on_pileup.R into the directory with your pileup files (suffixed by *.pileup) and running it by:
```
Rscript filtering_fasta_on_pileup.R
```

This script determines the consensus sequence in the mpileup file and outputs a fasta file for each pileup containing sequence(s) (for positions where the reference is covered by reads).

We do this additional step over just using the reference output by GATK's haplotypecaller, particularly for instances where we are using PCR-enrichment to generate our mitogenomes. This is because there are a few issues with using amplicons with Haplotypecaller (paraphrasing some of the discussion at the following link as well as associated posts: https://gatkforums.broadinstitute.org/gatk/discussion/8477/two-validated-variants-missed-by-haplotypecaller-using-mip-data-amplicon-like-data):

-- if you have high-coverage sequencing, some of the variants it finds will be PCR or sequencing noise. Haplotypecaller counts these errors against the max-num-haplpotypes/alleles/variants flags so you can get legit variation masked by the noise (when it constructs haplotypes incorporating the noise and those 'real variants' not output).

-- if the variant occurs towards the end of a fragment GATK doesn't trust it (because typically ends of reads are noisy with error, but in the case of an amplicon, sometimes the end of the read can legit be covering a nearby variant site).

In addition to outputting the fasta_file, the script will also output a pdf plot for each pileup showing coverage across the mitogenome, percentage of reads that started and stopped at each position, positions where a single nucleotide did not represent >70% of reads (and the subset of these positions where indels were indicated). The >70% cut-off for quality follows Morin et al. (2018), and such sites could be in need of additional scrutiny.

An alternative is running filtering_fasta_with_min_cov.R. This requires a file named "pileup_params.txt" which has the pileup file name in the first column, and the coverage below which you do not want any fasta contigs written out in the right column e.g.:
```
B5.pileup       793
B5split.pileup  793
B8.pileup       796
B8split.pileup  796
B9.pileup       792
B9split.pileup  792
```
Run this code by:
```
filtering_fasta_with_min_cov.R
```
### Programs/packages necessary for the pipeline:
```
data.table: M Dowle, A Srinivasan, T Short, S Lianoglou with contributions from R Saporta and E Antonyan (2015). data.table: Extension of Data.frame. R package version 1.9.6. http://CRAN.R-project.org/package=data.table  (for up-to-date citation information run citation("data.table" in R)

ggplot2: H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.

R: R Core Team. 2015. R: A language and environment for statistical computing. URL http://www.R-project.org/. R Foundation for Statistical Computing, Vienna, Austria. https://www.r-project.org/
```
Along with the programs above, to cite this pipeline:
```
Alexander, A. 4_filtering_fasta_on_pileup v0.0. Available from: https://github.com/laninsky/direct_mito_sequencing/edit/master/4_filtering_fasta_on_pileup/
```
### Version history
```
v0.0 This version of pipeline used in TBD
```
