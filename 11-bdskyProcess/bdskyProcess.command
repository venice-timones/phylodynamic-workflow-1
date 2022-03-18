#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/11-bdskyProcess
source activate nextstrain

# Create datefiles and plots
Rscript ./scripts/processBdsky.R
