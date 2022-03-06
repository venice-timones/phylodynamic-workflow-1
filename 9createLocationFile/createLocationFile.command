#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/9createLocationFile
source activate nextstrain

# Create datefile
Rscript ./scripts/location.R 