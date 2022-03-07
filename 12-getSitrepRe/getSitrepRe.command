#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/12-getSitrepRe
source activate nextstrain

# Create datefile
Rscript ./scripts/getSitrepRe.R "2022-02-19"