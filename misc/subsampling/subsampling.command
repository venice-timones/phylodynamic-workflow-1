#! /bin/bash

##### PRELIMINARIES
#Initialize environment
cd GitHub/gisaid-preprocessing/misc/subsampling
source activate nextstrain

##### subsample according to different parameters
# min-date -> minimum date to include
# max-date -> maximum date to include
augur filter \
    --metadata *.tsv \
    --min-date 2021-01-01 \
    --max-date 2021-07-31 \
    --exclude-ambiguous-dates-by any \
    --output-strains subsample.txt
augur filter \
    --metadata *.tsv \
    --sequences *.fasta \
    --exclude-all \
    --include subsample.txt \
    --output-metadata subsample.tsv \
    --output-sequences subsample.fasta