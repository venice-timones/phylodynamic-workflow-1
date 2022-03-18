#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/08-createDateFiles
source activate nextstrain

# Create datefile
Rscript ./scripts/date.R 