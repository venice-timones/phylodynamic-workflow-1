#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/13-coalskyProcess
source activate phylodynamics

# Create datefiles and plots
Rscript ./scripts/processCoalsky.R 
