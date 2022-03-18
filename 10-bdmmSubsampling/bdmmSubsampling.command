#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/10-bdmmSubsampling
source activate nextstrain

# Subsample for bdmm data
augur filter \
    --metadata input/*.tsv \
    --group-by division year month \
    --subsample-max-sequences 500 \
    --subsample-seed 1412 \
    --output-strains output/bdmm.txt
augur filter \
    --metadata input/*.tsv \
    --sequences input/*.fasta \
    --exclude-all \
    --include output/bdmm.txt \
    --output-metadata output/bdmm.tsv \
    --output-sequences output/bdmm.fasta
rm output/bdmm.txt