# 2_blast_fishing
After running 1_denovo (or obtaining assembled fasta sequence by some other means), you might want to screen it to pull just the "mitogenomic-like" fragments through to the final step (which is estimating coverage and making the final base calls).

To run, we need to modify our mito_shell_params.txt from 1_denovo (if you are joining the pipeline at this step just leave the first four lines blank)
#
```
path/to/trinity/executable #As for Step 1, leave blank if starting at this step
path/to/samples_file/with/read/locations #As for Step 1, leave blank if starting at this step
max_memory #As for Step 1, leave blank if starting at this step
number_of_cores #As for Step 1, leave blank if starting at this step
### The following lines are new to this step:
path/to/blastn/executable
Step_1 or location/of/file/giving/path/to/sample/fasta/files # If you are coming from Step_1 and running this script from the same 
# directory then you can just put Step_1 and the script will grab the info on your sample fasta names from Line 2 of this file
path/to/reference/fasta/file # You can have multiple references in this file
percentage_identity # What percentage identity cut-off you'd like to use for matching your sample fastas to the reference
```

```
Trinity # See Step 1 instructions for more details
samples_file.txt # See Step 1 instructions for more details
200G # See Step 1 instructions for more details
8 # See Step 1 instructions for more details

Step_1
``

grep ">" B4_trinity_out_dir.Trinity.fasta | awk '{print $2}' | sed 's/len=//g' | sort -n
