#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/02-combineSequences
source activate phylodynamics

# Concatenate sequences and metadata to make one set for Philippine samples
cat input/*.fasta > output/combineSequences.fasta
cat input/*.tsv > output/combineSequences.tsv