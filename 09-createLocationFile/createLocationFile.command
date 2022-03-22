#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/09-createLocationFile
source activate phylodynamics

# Create datefile
Rscript ./scripts/location.R 