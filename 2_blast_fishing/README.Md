# 2_blast_fishing
After running 1_denovo (or obtaining assembled fasta sequence by some other means), you might want to screen it to pull just the "mitogenomic-like" fragments through to the final step (which is estimating coverage and making the final base calls).

To do this, 2_blast_fishing needs the following from you:
1) A parameters file (mito_shell_params.txt), described below (has additional lines added compared with 1_denovo)
2) A reference fasta file (you can have multiple references in this file)
3) If you are joining the pipeline at this step rather than having down Step 1, you'll also need a samples_fasta_file (described below too - just lists the path to each of your sample's fasta files).

Additionally you'll need access to a BLAST+ and seqtk installation (you'll specify the paths in mito_shell_params.txt)

To run, we need to modify our mito_shell_params.txt from 1_denovo (if you are joining the pipeline at this step just leave the first four lines blank).

# The parameters file (mito_shell_params.txt)
```
path/to/trinity/executable                                   # As for Step 1, leave blank if starting at this step
path/to/samples_file/with/read/locations                     # As for Step 1, leave blank if starting at this step
max_memory                                                   # As for Step 1, leave blank if starting at this step
number_of_cores                                              # As for Step 1, leave blank if starting at this step
path/to/blast/bin/makeblastdb                                # New to this step: pathway to makeblastdb executable
path/to/blast/bin/blastn                                     # New to this step: pathway to blastn executable
path/to/seqtk                                                # New to this step: pathway to seqtk exectuable
Step_1 or location/of/file/giving/path/to/sample/fasta/files # New to this step: If you are coming from Step_1 and running this script from the same directory then you can just put Step_1 and the script will grab the info on your sample fasta names from Line 2 of mito_shell_params.txt. If not, you'll need to give location/of/file/giving/path/to/sample/fasta/files (described below)
path/to/reference/fasta/file                                 # New to this step: You can have multiple references in this file
percentage_identity                                          # New to this step: What percentage identity cut-off you'd like to use for matching your sample fastas to the 
```
e.g. coming from Step_1 (remove comments if copying and pasting)
```
Trinity          # We defined this line in Step 1
samples_file.txt # We defined this line in Step 1
200G             # We defined this line in Step 1
8                # We defined this line in Step 1
makeblastdb      # Already installed in path, so just listing executable
blastn           # Already installed in path, so just listing executable
seqtk            # Already installed in path, so just listing executable
Step_1           # This option will grab sample names/fasta locations from samples_file.txt
reference.fa     # located in the working folder so not giving absolute path
75               # using a relatively loose threshold of a 75% match to the reference
```
e.g. coming into this step after previously getting a fasta file for each sample (remove comments if copying and pasting)
```
                       # Leave this line blank
                       # Leave this line blank
                       # Leave this line blank
                       # Leave this line blank
makeblastdb            # Already installed in path, so just listing executable
blastn                 # Already installed in path, so just listing executable
seqtk                  # Already installed in path, so just listing executable
sample_fasta_names.txt # The text file with the path to each sample's fasta file (described below)
reference.fa           # located in the working folder so not giving absolute path
75                     # using a relatively loose threshold of a 75% match to the reference
```

# The text file with the path to each sample's fasta file
(only needed if you aren't sticking Step_1 in at Line 8 - just gives name and location of the assembly for each sample, tab delimited)
```
B1	/data/alana/wasp/B1_trinity_out_dir.Trinity.fasta
B2	/data/alana/wasp/B2_trinity_out_dir.Trinity.fasta
B3	/data/alana/wasp/B3_trinity_out_dir.Trinity.fasta
B4	/data/alana/wasp/B4_trinity_out_dir.Trinity.fasta
B5	/data/alana/wasp/B5_trinity_out_dir.Trinity.fasta
B6	/data/alana/wasp/B6_trinity_out_dir.Trinity.fasta
B7	/data/alana/wasp/B7_trinity_out_dir.Trinity.fasta
```

# To execute 2_blast_fishing.sh:
Make sure mito_shell_params.txt is in the same directory as 2_blast_fishing.sh, and then...
```
bash 2_blast_fishing.sh
```
