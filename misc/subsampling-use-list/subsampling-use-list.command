#! /bin/bash

##### PRELIMINARIES
#Initialize environment
cd GitHub/gisaid-preprocessing/misc/subsampling-use-list
source activate nextstrain

augur filter \
    --metadata INPUT/*.tsv \
    --sequences INPUT/*.fasta \
    --exclude-all \
    --include INPUT/*.txt \
    --output-metadata OUTPUT/subsample-use-list.result.tsv \
    --output-sequences OUTPUT/subsample-use-list.result.fasta