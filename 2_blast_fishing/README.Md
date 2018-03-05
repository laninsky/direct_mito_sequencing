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
path/to/trinity/executable #As for Step 1, leave blank if starting at this step
path/to/samples_file/with/read/locations #As for Step 1, leave blank if starting at this step
max_memory #As for Step 1, leave blank if starting at this step
number_of_cores #As for Step 1, leave blank if starting at this step
### The following lines (Line 5+) are new to this step:
path/to/blast/bin/makeblastdb # pathway to makeblastdb executable
path/to/blast/bin/blastn# pathway to blastn executable
path/to/seqtk # path to seqtk exectuable
Step_1 or location/of/file/giving/path/to/sample/fasta/files # If you are coming from Step_1 and running this script from the same 
# directory then you can just put Step_1 and the script will grab the info on your sample fasta names from Line 2 of this file
path/to/reference/fasta/file # You can have multiple references in this file
percentage_identity # What percentage identity cut-off you'd like to use for matching your sample fastas to the reference
```
e.g. coming from Step_1
```
Trinity # See Step 1 instructions for more details
samples_file.txt # See Step 1 instructions for more details
200G # See Step 1 instructions for more details
8 # See Step 1 instructions for more details
makeblastdb # Already installed in path, so just listing executable
blastn # Already installed in path, so just listing executable
seqtk # Already installed in path, so just listing executable


Step_1
``
e.g. coming into this step after previously getting a fasta file for each sample


grep ">" B4_trinity_out_dir.Trinity.fasta | awk '{print $2}' | sed 's/len=//g' | sort -n
