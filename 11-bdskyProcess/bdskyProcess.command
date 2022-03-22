#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/11-bdskyProcess
source activate phylodynamics

# Create datefiles and plots
Rscript ./scripts/processBdsky.R
