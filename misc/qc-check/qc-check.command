#! /bin/bash

##### PRELIMINARIES
#Initialize environment
cd GitHub/gisaid-preprocessing/misc/qc-check
source activate nextstrain

##### subsample according to different parameters
# min-date -> minimum date to include
# max-date -> maximum date to include
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta INPUT/*.fasta \
   --output-tsv=qc-check.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R 
rm qc-check.result.tsv
augur filter \
    --metadata INPUT/*.tsv \
    --sequences INPUT/*.fasta \
    --exclude-all \
    --include qc-check.filter.txt \
    --output-metadata OUTPUT/qc-check.result.tsv \
    --output-sequences OUTPUT/qc-check.result.fasta 
rm qc-check.filter.txt  
rm -rf nextclade