#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/13-coalskyProcess
source activate nextstrain

# Create datefiles and plots
Rscript ./scripts/processCoalsky.R 
