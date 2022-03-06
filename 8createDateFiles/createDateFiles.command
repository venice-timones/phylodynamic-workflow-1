#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/8createDateFiles
source activate nextstrain

# Create datefile
Rscript ./scripts/date.R 