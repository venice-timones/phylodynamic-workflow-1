#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/06-alignSequences
source activate phylodynamics

# Download latest reference
nextclade dataset get --name 'sars-cov-2' --output-dir 'scripts/reference'

# Filter sequences
augur align \
    --sequences input/*.fasta \
    --reference-sequence 'scripts/reference/reference.fasta' \
    --remove-reference \
    --output output/align.fasta

# Remove intermediate files
rm output/*.log
rm output/*.csv