#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/08-createDateFiles
source activate nextstrain

# Create datefile
Rscript ./scripts/date.R 