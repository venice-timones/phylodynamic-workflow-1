#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/13-coalskyProcess
source activate nextstrain

# Create datefiles and plots
Rscript ./scripts/processCoalsky.R 
