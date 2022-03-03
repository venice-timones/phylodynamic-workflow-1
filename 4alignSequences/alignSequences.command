#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/4alignSequences
source activate nextstrain

# Download latest reference
nextclade dataset get --name 'sars-cov-2' --output-dir 'scripts/reference'

# Filter sequences
augur align \
    --sequences input/*.fasta \
    --reference-sequence 'scripts/reference/reference.fasta' \
    --remove-reference \
    --output output/align.fasta

# Remove other results from nextclade
rm output/*.log
rm output/*.csv