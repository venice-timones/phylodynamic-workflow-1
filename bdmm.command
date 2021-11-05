#! /bin/bash

###EDIT THIS ONLY!!!###
declare -r date=211102
declare -r random=260

##### PRELIMINARIES
#Initialize environment
cd Augur
cd ncov-master
source activate nextstrain

##### BDMM
#Randomly sample 260 NCR samples
augur filter \
    --metadata preprocess/$date.ncr.metadata.sanitized.clean.tsv \
    --min-date 2021-01-01 \
    --max-date 2021-12-31 \
    --exclude-ambiguous-dates-by any \
    --subsample-max-sequences $random \
    --output-strains preprocess/$date.ncrbdmm.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.ncrbdmm.filter.txt \
    --output-metadata preprocess/$date.ncrbdmm.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/$date.ncrbdmm.sequences.sanitized.clean.fasta
cat preprocess/$date.ncrbdmm.sequences.sanitized.clean.fasta \
    preprocess/result/$date.mindanao.sequences.sanitized.clean.fasta \
    > preprocess/result/$date.bdmm.sequences.sanitized.clean.fasta
cat preprocess/$date.ncrbdmm.metadata.sanitized.clean.tsv \
    <(tail +2 preprocess/result/$date.mindanao.metadata.sanitized.clean.tsv) \
    > preprocess/result/$date.bdmm.metadata.sanitized.clean.tsv

##### GRAPHS
Rscript ./scripts/graph.bdmm.R $date.bdmm


