#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/09-createLocationFile
source activate nextstrain

# Create datefile
Rscript ./scripts/location.R 