#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/07-computePriors
source activate nextstrain

# Calculate info
Rscript ./scripts/info.R 

# Calculate priors
Rscript ./scripts/priors.R 