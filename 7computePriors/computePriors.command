#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/7computePriors
source activate nextstrain

# Calculate info
Rscript ./scripts/info.R 

# Calculate priors
Rscript ./scripts/priors.R 