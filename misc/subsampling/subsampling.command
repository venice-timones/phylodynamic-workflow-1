#! /bin/bash

##### PRELIMINARIES
#Initialize environment
cd GitHub/gisaid-preprocessing/misc/subsampling
source activate nextstrain

##### subsample according to different parameters
# min-date -> minimum date to include
# max-date -> maximum date to include
augur filter \
    --metadata INPUT/*.tsv \
    --min-date 2019-01-01 \
    --max-date 2020-07-31 \
    --exclude-ambiguous-dates-by any \
    --output-strains subsample.result.txt
augur filter \
    --metadata INPUT/*.tsv \
    --sequences INPUT/*.fasta \
    --exclude-all \
    --include subsample.result.txt \
    --output-metadata OUTPUT/subsample.result.tsv \
    --output-sequences OUTPUT/subsample.result.fasta
rm subsample.result.txt