#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/15-getSubModel
source activate phylodynamics

# Perform jmodel test
iqtree -s input/*.fasta -m MF

# Move output file to output folder
mv input/*.log output/

# Remove intermediate files
rm input/*fasta.*