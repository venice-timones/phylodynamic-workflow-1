#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/12-getSitrepRe
source activate phylodynamics

# Create datefile
Rscript ./scripts/getSitrepRe.R "2022-02-19"