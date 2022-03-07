#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/11bdskyProcess
source activate nextstrain

# Create datefiles and plots
Rscript ./scripts/processBdsky.R 
