#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/04-qualityCheckSequences
source activate nextstrain

# Declare sequences and metadata names
declare sequence=$(ls input/*.fasta)  
declare metadata=$(ls input/*.tsv)  

# Download latest reference
nextclade dataset get --name 'sars-cov-2' --output-dir 'scripts/reference'

# Perform QC check
nextclade \
   --in-order \
   --input-dataset='scripts/reference' \
   --input-fasta=$sequence \
   --output-tsv=output/qcresult.tsv \
   --output-dir=output/

# List sequences that passed the QC
Rscript ./scripts/filter.R 

# Remove other results from nextclade
rm output/*.fasta
rm output/*.csv
rm output/*.tsv

# Filter sequences
augur filter \
    --metadata $metadata \
    --sequences $sequence \
    --exclude-all \
    --include output/qcresult.txt \
    --output-metadata output/clean.tsv \
    --output-sequences output/clean.fasta

# Remove intermediate files
rm output/*.txt
