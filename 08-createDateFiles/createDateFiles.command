#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/08-createDateFiles
source activate phylodynamics

# Create datefile
Rscript ./scripts/date.R 