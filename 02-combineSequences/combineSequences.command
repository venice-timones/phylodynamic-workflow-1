#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/02-combineSequences
source activate nextstrain

# Concatenate sequences and metadata to make one set for Philippine samples
cat input/*.fasta > output/combineSequences.fasta
cat input/*.tsv > output/combineSequences.tsv