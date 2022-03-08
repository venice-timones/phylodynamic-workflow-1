#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/03-subsampleSequencesMindanao
source activate nextstrain

# Subsample to mindanao
augur filter \
    --metadata input/*.tsv \
    --query "((division == 'Zamboanga Peninsula') | (division == 'Northern Mindanao') | (division == 'Davao Region') | (division == 'Soccsksargen') | (division == 'Caraga') | (division == 'Bangsamoro Autonomous Region In Muslim Mindanao'))" \
    --exclude-ambiguous-dates-by any \
    --output-strains output/mindanao.txt
augur filter \
    --metadata input/*.tsv \
    --sequences input/*.fasta \
    --exclude-all \
    --include output/mindanao.txt \
    --output-metadata output/mindanao.tsv \
    --output-sequences output/mindanao.fasta
rm output/mindanao.txt