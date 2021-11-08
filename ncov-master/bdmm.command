#! /bin/bash

###EDIT THIS ONLY!!!###
declare -r date=211102
declare -r random=260

##### PRELIMINARIES
#Initialize environment
cd GitHub
cd gisaid-preprocessing
cd ncov-master
source activate nextstrain

##### BDMM
#Randomly sample 260 NCR samples
augur filter \
    --metadata intermediate/$date.ncr.metadata.sanitized.clean.tsv \
    --min-date 2021-01-01 \
    --max-date 2021-12-31 \
    --exclude-ambiguous-dates-by any \
    --subsample-max-sequences $random \
    --subsample-seed 100
    --output-strains intermediate/$date.ncrbdmm.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.ncrbdmm.filter.txt \
    --output-metadata intermediate/$date.ncrbdmm.metadata.sanitized.clean.tsv \
    --output-sequences intermediate/$date.ncrbdmm.sequences.sanitized.clean.fasta
cat intermediate/$date.ncrbdmm.sequences.sanitized.clean.fasta \
    output/$date.mindanao.sequences.sanitized.clean.fasta \
    > output/$date.bdmm.sequences.sanitized.clean.fasta
cat intermediate/$date.ncrbdmm.metadata.sanitized.clean.tsv \
    <(tail +2 output/$date.mindanao.metadata.sanitized.clean.tsv) \
    > output/$date.bdmm.metadata.sanitized.clean.tsv

##### GRAPHS
Rscript ./scripts/graph.R $date.bdmm




